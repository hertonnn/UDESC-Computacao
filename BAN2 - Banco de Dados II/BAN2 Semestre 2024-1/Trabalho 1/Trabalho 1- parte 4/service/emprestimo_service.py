import psycopg2
from psycopg2.extensions import connection
from typing import Optional, Set, List
from datetime import date, timedelta
from decimal import Decimal

import exceptions 

from model.usuario_model import Usuario, UsuarioModel 
from model.exemplar_model import ExemplarModel 
from model.emprestimo_model import Emprestimo, EmprestimoModel 
from model.reserva_model import ReservaModel
from service.reserva_service import ReservaService
from model.emprestimo_model import LivroEmprestadoView 

class EmprestimoService:

    def __init__(self, conn: connection):
        self.conn = conn
        self.usuario_model = UsuarioModel()
        self.exemplar_model = ExemplarModel()
        self.emprestimo_model = EmprestimoModel()
        self.reserva_service = ReservaService(conn)

    def realizar_emprestimo(self, id_usuario: int, ids_exemplares: List[int], id_bibliotecario_logado: int) -> int:
 
        if not ids_exemplares:
            raise exceptions.NegocioException("Nenhum exemplar fornecido para o empréstimo.")

        try:
            
            tempo_emprestimo = self.get_tempo_emprestimo_usuario(id_usuario)

            data_hoje = date.today()
            data_devolucao = data_hoje + timedelta(days=tempo_emprestimo)
            
            novo_emprestimo = Emprestimo(
                data_emprestimo = data_hoje,
                data_devolucao_prevista = data_devolucao,
                id_usuario = id_usuario,
                id_bibliotecario = id_bibliotecario_logado
            )
            
            id_emprestimo = self.emprestimo_model.create_emprestimo(novo_emprestimo, self.conn) 
            
            ids_reservas_para_concluir = []

            
            for id_exemplar in ids_exemplares:
                
                exemplar = self.exemplar_model.get_exemplar_by_id(id_exemplar, self.conn)
                if not exemplar:
                    raise exceptions.RecursoNaoEncontradoException(f"Exemplar {id_exemplar} não encontrado.")

                id_reserva_para_concluir = None
                if exemplar.situacao == 'reservado':
                    reserva_ativa = self.reserva_service.verificar_reserva_ativa(id_exemplar)
                    
                    if reserva_ativa and reserva_ativa.id_usuario != id_usuario:
                        raise exceptions.ReservaException(f"Exemplar {id_exemplar} está reservado para outro usuário.")
                    elif reserva_ativa and reserva_ativa.id_usuario == id_usuario:
                        ids_reservas_para_concluir.append(reserva_ativa.id_reserva)
                    else:
                        raise exceptions.NegocioException(f"Erro de integridade: Exemplar {id_exemplar} 'reservado' sem reserva ativa.")
                
                self.emprestimo_model.link_exemplar_to_emprestimo(id_emprestimo, id_exemplar, self.conn)
                
                self.exemplar_model.update_situacao(id_exemplar, 'emprestado', self.conn)
                
            for id_reserva in ids_reservas_para_concluir:
                self.reserva_service.concluir_reserva_sem_commit(id_reserva)

            self.conn.commit()
            return id_emprestimo

        except (psycopg2.Error, Exception) as e:
            self.conn.rollback() 

            err_msg = str(e)
            err_msg_lower = err_msg.lower()
            
            clean_message = err_msg.split('\n')[0]
            if clean_message.startswith("ERRO: "):
                clean_message = clean_message[6:]

            if "multa pendente" in err_msg_lower: 
                raise exceptions.PendenciaException(clean_message)
            if "livros atrasados" in err_msg_lower:
                raise exceptions.PendenciaException(clean_message)
            if "limite foi atingido" in err_msg_lower: 
                raise exceptions.LimiteExcedidoException(clean_message)
            if "coleção reservada" in err_msg_lower: 
                raise exceptions.ColecaoReservadaException(clean_message)
            if "já está emprestado" in err_msg_lower:
                raise exceptions.NegocioException(clean_message)
            
            if isinstance(e, (exceptions.NegocioException, exceptions.RecursoNaoEncontradoException, exceptions.ReservaException)):
                raise e

            raise exceptions.NegocioException(f"Erro inesperado ao realizar empréstimo: {e}")

    def realizar_devolucao(self, id_exemplar: int) -> Emprestimo:
        try:

            emprestimo = self.emprestimo_model.get_emprestimo_ativo_by_exemplar_id(id_exemplar, self.conn) 
            if not emprestimo:
                raise exceptions.RecursoNaoEncontradoException("Este exemplar não consta como emprestado.")
            
            id_emprestimo = emprestimo.id_emprestimo

            reserva_ativa = self.reserva_service.verificar_reserva_ativa(id_exemplar)
            nova_situacao = 'reservado' if reserva_ativa else 'disponível'
            
            ids_ainda_emprestados = self._get_ids_exemplares_ainda_emprestados(id_emprestimo)
            
            is_last_item = (len(ids_ainda_emprestados) == 1 and ids_ainda_emprestados[0] == id_exemplar)

            self.exemplar_model.update_situacao(id_exemplar, nova_situacao, self.conn) 
            
            if is_last_item:
                
                data_hoje = date.today()
                placeholder_multa = Decimal('0.00')
                
                self.emprestimo_model.update_devolucao(
                    id_emprestimo, data_hoje, placeholder_multa, self.conn
                ) 

            self.conn.commit()
            
            return self.emprestimo_model.get_emprestimo_by_id(id_emprestimo, self.conn) 

        except (psycopg2.Error, exceptions.NegocioException, exceptions.RecursoNaoEncontradoException) as e:
            self.conn.rollback()
            raise e
        except Exception as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao realizar devolução: {e}")
    
    def renovar_emprestimo(self, id_usuario: int, id_livro: int) -> date:
        
        id_emprestimo = self.emprestimo_model.get_emprestimo_ativo_by_usuario_e_livro(
            id_usuario, id_livro, self.conn
        )

        if id_emprestimo is None:
            raise exceptions.RecursoNaoEncontradoException("Nenhum empréstimo ativo encontrado para este usuário e este livro.")

        try:

            emprestimo = self.emprestimo_model.get_emprestimo_by_id(id_emprestimo, self.conn)
            if not emprestimo:
                raise exceptions.RecursoNaoEncontradoException("Empréstimo não encontrado.")
            
            exemplares = self.emprestimo_model.get_exemplares_of_emprestimo(id_emprestimo, self.conn)
            for ex in exemplares:
                if self.reserva_service.verificar_reserva_ativa(ex.id_exemplar):
                    raise exceptions.ReservaException(f"Renovação bloqueada. O exemplar {ex.id_exemplar} possui reserva.")
            
            tempo_emprestimo = self.get_tempo_emprestimo_usuario(emprestimo.id_usuario)
            
            nova_data_prevista = date.today() + timedelta(days = tempo_emprestimo)

            self.emprestimo_model.update_renovacao(id_emprestimo, nova_data_prevista, self.conn)

            self.conn.commit()

            return nova_data_prevista
            
        except(psycopg2.Error, Exception) as e:
            self.conn.rollback()
            
            err_msg = str(e).lower()
            if "livros atrasados" in err_msg:
                raise exceptions.PendenciaException(str(e))
            
            if "limite de renovação" in err_msg:
                raise exceptions.LimiteExcedidoException(str(e))
            
            if isinstance(e, (exceptions.NegocioException, exceptions.RecursoNaoEncontradoException, exceptions.ReservaException)):
                raise e
            
            raise exceptions.NegocioException(f"Erro inesperado ao renovar empréstimo: {e}")

    def get_tempo_emprestimo_usuario(self, id_usuario: int) -> int:

        usuario = self.usuario_model.get_by_id(id_usuario, self.conn) 
        if not usuario:
            raise exceptions.RecursoNaoEncontradoException(f"Usuário {id_usuario} não encontrado.")
        
        categoria = usuario.categoria
        
        if categoria not in ('aluno_grad', 'aluno_pos', 'professor', 'professor_pos'):
            raise exceptions.NegocioException("Categoria de usuário desconhecida.")
        
        tempo_emprestimo = self.emprestimo_model.get_tempo_emprestimo_por_usuario(usuario, self.conn)
        
        if tempo_emprestimo is not None:
            return tempo_emprestimo
        else:
            raise exceptions.NegocioException(f"Dados de empréstimo não encontrados para o usuário {id_usuario}.")
    
    def listar_emprestimos_ativos_por_usuario(self, id_usuario: int) -> Set[Emprestimo]:
        try: 
            return self.emprestimo_model.get_emprestimos_ativos_by_usuario_id(id_usuario, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar empréstimos ativos: {e}")
        
    def _get_ids_exemplares_ainda_emprestados(self, id_emprestimo: int) -> List[int]:

        sql = """
            SELECT ex.id_exemplar
            FROM Exemplar ex
            JOIN Emprestimo_Exemplar ee ON ex.id_exemplar = ee.id_exemplar
            WHERE ee.id_emprestimo = %s
            AND ex.situacao = 'emprestado'
        """

        ids_emprestados = []
        with self.conn.cursor() as cursor:
            cursor.execute(sql, (id_emprestimo,))
            rows = cursor.fetchall()
            for row in rows:
                ids_emprestados.append(row[0])
        return ids_emprestados
    
    def listar_livros_emprestados_ativos(self, id_usuario: int) -> Set[LivroEmprestadoView]:

        try: 
            return self.emprestimo_model.get_livros_emprestados_ativos(id_usuario, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar livros emprestados: {e}")
        
    def listar_emprestimos_atrasados_com_nomes(self) -> Set[tuple]:
        try:
            emprestimos = self.emprestimo_model.list_atrasados_com_nomes(self.conn)
            if not emprestimos:
                raise exceptions.RecursoNaoEncontradoException("Nenhum empréstimo atrasado encontrado.")
            return emprestimos
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar empréstimos atrasados: {e}")
        
    def listar_exemplares_emprestados_ativos(self) -> Set[tuple]:
        try:
            emprestimos = self.emprestimo_model.list_exemplares_emprestados_ativos_com_nomes(self.conn)
            if not emprestimos:
                raise exceptions.RecursoNaoEncontradoException("Nenhum exemplar emprestado ativamente.")
            return emprestimos
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar exemplares emprestados: {e}")
        
    