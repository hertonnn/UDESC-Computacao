import psycopg2
from psycopg2.extensions import connection
from typing import Optional, Set
from datetime import date

import exceptions

from model.reserva_model import Reserva, ReservaModel
from model.exemplar_model import ExemplarModel
from model.emprestimo_model import Emprestimo, EmprestimoModel

class ReservaService:

    def __init__(self, conn: connection):

        self.conn = conn
        self.reserva_model = ReservaModel()
        self.exemplar_model = ExemplarModel()
        self.emprestimo_model = EmprestimoModel()
        
    def realizar_reserva(self, id_usuario: int, id_livro: int) -> int:

        try:
            data_hoje = date.today()
            
            emprestimos_ativos = self.emprestimo_model.get_emprestimos_ativos_by_usuario_id(id_usuario, self.conn) 
            for emp in emprestimos_ativos:
                if (emp.multas and emp.multas > 0) or (emp.data_devolucao_prevista < data_hoje): 
                    raise exceptions.PendenciaException("Usuário com pendências (multa ou atraso), não pode reservar.")

            for emp in emprestimos_ativos:
                exemplares_do_emprestimo = self.emprestimo_model.get_exemplares_of_emprestimo(emp.id_emprestimo, self.conn) 
                for ex in exemplares_do_emprestimo:
                    if ex.id_livro == id_livro:
                        raise exceptions.NegocioException("Usuário não pode reservar um livro que já está em seu nome.")

            reservas_do_usuario = self.reserva_model.get_reservas_ativas_by_usuario_id(id_usuario, self.conn) 
            for res in reservas_do_usuario:
                exemplar_da_reserva = self.exemplar_model.get_exemplar_by_id(res.id_exemplar, self.conn) 
                if exemplar_da_reserva and exemplar_da_reserva.id_livro == id_livro:
                    raise exceptions.NegocioException("Usuário já possui uma reserva ativa para este livro.")
            
            exemplares_do_livro = self.exemplar_model.list_exemplares_of_livro(id_livro, self.conn) 
            if not exemplares_do_livro:
                raise exceptions.RecursoNaoEncontradoException(f"Nenhum exemplar encontrado para o livro {id_livro}.")

            exemplar_alvo = None
            for ex in exemplares_do_livro:
                if ex.situacao == 'emprestado':
                    exemplar_alvo = ex
                    break 
            
            if not exemplar_alvo:
                raise exceptions.NegocioException("Não é possível reservar este livro. Todos os exemplares estão disponíveis (devem ser emprestados) ou já se encontram na fila de reserva.")

            nova_reserva = Reserva(
                data_reserva = data_hoje,
                situacao = 'ativa',
                id_usuario = id_usuario,
                id_exemplar = exemplar_alvo.id_exemplar 
            )
            id_reserva = self.reserva_model.create_reserva(nova_reserva, self.conn) 
            
            self.conn.commit()
            return id_reserva

        except (psycopg2.Error, exceptions.NegocioException, exceptions.PendenciaException, exceptions.RecursoNaoEncontradoException) as e:
            self.conn.rollback()
            raise e 
        except Exception as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao realizar reserva: {e}")
        
    def verificar_reserva_ativa(self, id_exemplar: int) -> Optional[Reserva]:

        return self.reserva_model.get_proxima_reserva_na_fila(id_exemplar, self.conn)

    def concluir_reserva_sem_commit(self, id_reserva: int) -> None:

        self.reserva_model.update_situacao_reserva(id_reserva, 'concluída', self.conn)
        
    def concluir_reserva(self, id_reserva: int) -> None:

        try:
            self.concluir_reserva_sem_commit(id_reserva)
            self.conn.commit()
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro ao concluir reserva: {e}")

    def cancelar_reserva(self, id_reserva: int) -> None:

        try:
            reserva = self.reserva_model.get_reserva_by_id(id_reserva, self.conn)
            if not reserva or reserva.situacao != 'ativa':
                raise exceptions.NegocioException("Reserva não encontrada ou não está ativa.")
                
            id_exemplar_alvo = reserva.id_exemplar

            self.reserva_model.update_situacao_reserva(id_reserva, 'cancelada', self.conn)

            exemplar = self.exemplar_model.get_exemplar_by_id(id_exemplar_alvo, self.conn)
            
            if exemplar and exemplar.situacao == 'reservado':
                proxima_reserva = self.verificar_reserva_ativa(id_exemplar_alvo)
                
                if not proxima_reserva:
                    self.exemplar_model.update_situacao(id_exemplar_alvo, 'disponível', self.conn)

            self.conn.commit()
            
        except (psycopg2.Error, exceptions.NegocioException) as e:
            self.conn.rollback()
            raise e
        except Exception as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao cancelar reserva: {e}")

    def listar_emprestimos_ativos_por_usuario(self, id_usuario: int) -> Set[Emprestimo]:

        try:
            return self.emprestimo_model.get_emprestimos_ativos_by_usuario_id(id_usuario, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar empréstimos ativos: {e}")
        
    def listar_reservas_ativas_com_nomes(self) -> Set[tuple]:
        try:
            reservas = self.reserva_model.list_ativas_com_nomes(self.conn)
            if not reservas:
                raise exceptions.RecursoNaoEncontradoException("Nenhuma reserva ativa encontrada.")
            return reservas
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar reservas ativas: {e}")