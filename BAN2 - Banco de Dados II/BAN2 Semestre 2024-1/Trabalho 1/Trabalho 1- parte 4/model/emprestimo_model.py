import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from datetime import date
from decimal import Decimal
from model.exemplar_model import Exemplar
from model.livro_model import Livro

@dataclass(frozen=True, eq=True)
class Emprestimo:
    data_emprestimo: date
    data_devolucao_prevista: date
    id_usuario: int
    id_bibliotecario: int 
    id_emprestimo: Optional[int] = None
    data_devolucao_real: Optional[date] = None
    multas: Optional[Decimal] = None
    renovacoes: Optional[int] = None

@dataclass(frozen=True, eq=True)
class LivroEmprestadoView:
    id_livro: int
    titulo: str
    data_devolucao_prevista: date
    id_emprestimo: int

class EmprestimoModel:

    def create_emprestimo(self, emprestimo: Emprestimo, conn: connection) -> int:

        sql = """
            INSERT INTO Emprestimo (
                data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario
            ) 
            VALUES (%s, %s, %s, %s)
            RETURNING id_emprestimo
        """
        
        params = (
            emprestimo.data_emprestimo,
            emprestimo.data_devolucao_prevista,
            emprestimo.id_usuario,
            emprestimo.id_bibliotecario
        )

        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]
        return novo_id

    def link_exemplar_to_emprestimo(self, id_emprestimo: int, id_exemplar: int, conn: connection) -> None:

        sql = "INSERT INTO Emprestimo_Exemplar (id_emprestimo, id_exemplar) VALUES (%s, %s)"
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_emprestimo, id_exemplar))

    def get_emprestimo_by_id(self, id_emprestimo: int, conn: connection) -> Optional[Emprestimo]:

        sql = """
            SELECT id_emprestimo, data_emprestimo, data_devolucao_prevista,
                   data_devolucao_real, multas, renovacoes,
                   id_usuario, id_bibliotecario
            FROM Emprestimo 
            WHERE id_emprestimo = %s
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_emprestimo,))
            row = cursor.fetchone()
            
            if row:
                return Emprestimo(
                    id_emprestimo=row[0],
                    data_emprestimo=row[1],
                    data_devolucao_prevista=row[2],
                    data_devolucao_real=row[3],
                    multas=row[4],
                    renovacoes=row[5],
                    id_usuario=row[6],
                    id_bibliotecario=row[7]
                )
            else:
                return None

    def get_exemplares_of_emprestimo(self, id_emprestimo: int, conn: connection) -> Set[Exemplar]:

        lista_exemplares: Set[Exemplar] = set()
        sql = """
            SELECT e.id_exemplar, e.numero_exemplar, e.situacao, 
                   e.is_colecao_reservada, e.id_livro 
            FROM Exemplar e 
            JOIN Emprestimo_Exemplar ee ON e.id_exemplar = ee.id_exemplar 
            WHERE ee.id_emprestimo = %s
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_emprestimo,))
            for row in cursor:
                lista_exemplares.add(Exemplar(
                    id_exemplar=row[0],
                    numero_exemplar=row[1],
                    situacao=row[2],
                    is_colecao_reservada=row[3],
                    id_livro=row[4]
                ))
        return lista_exemplares

    def get_emprestimo_ativo_by_exemplar_id(self, id_exemplar: int, conn: connection) -> Optional[Emprestimo]:
 
        sql = """
            SELECT e.id_emprestimo, e.data_emprestimo, e.data_devolucao_prevista,
                   e.data_devolucao_real, e.multas, e.renovacoes,
                   e.id_usuario, e.id_bibliotecario
            FROM Emprestimo e 
            JOIN Emprestimo_Exemplar ee ON e.id_emprestimo = ee.id_emprestimo 
            WHERE ee.id_exemplar = %s AND e.data_devolucao_real IS NULL
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_exemplar,))
            row = cursor.fetchone() # Um exemplar só pode estar em um empréstimo ativo
            
            if row:
                return Emprestimo(
                    id_emprestimo=row[0],
                    data_emprestimo=row[1],
                    data_devolucao_prevista=row[2],
                    data_devolucao_real=row[3],
                    multas=row[4],
                    renovacoes=row[5],
                    id_usuario=row[6],
                    id_bibliotecario=row[7]
                )
            else:
                return None

    def get_emprestimos_ativos_by_usuario_id(self, id_usuario: int, conn: connection) -> Set[Emprestimo]:
 
        lista_emprestimos: Set[Emprestimo] = set()
        sql = """
            SELECT id_emprestimo, data_emprestimo, data_devolucao_prevista, 
                   data_devolucao_real, multas, renovacoes, 
                   id_usuario, id_bibliotecario
            FROM Emprestimo 
            WHERE id_usuario = %s AND data_devolucao_real IS NULL
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            for row in cursor:
                lista_emprestimos.add(Emprestimo(
                    id_emprestimo=row[0],
                    data_emprestimo=row[1],
                    data_devolucao_prevista=row[2],
                    data_devolucao_real=row[3],
                    multas=row[4],
                    renovacoes=row[5],
                    id_usuario=row[6],
                    id_bibliotecario=row[7]
                ))
        return lista_emprestimos

    def get_emprestimos_atrasados(self, conn: connection) -> Set[Emprestimo]:

        lista_emprestimos: Set[Emprestimo] = set()
        sql = """
            SELECT id_emprestimo, data_emprestimo, data_devolucao_prevista, 
                   data_devolucao_real, multas, renovacoes, 
                   id_usuario, id_bibliotecario
            FROM Emprestimo 
            WHERE data_devolucao_real IS NULL AND data_devolucao_prevista < CURRENT_DATE
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_emprestimos.add(Emprestimo(
                    id_emprestimo=row[0],
                    data_emprestimo=row[1],
                    data_devolucao_prevista=row[2],
                    data_devolucao_real=row[3],
                    multas=row[4],
                    renovacoes=row[5],
                    id_usuario=row[6],
                    id_bibliotecario=row[7]
                ))
        return lista_emprestimos
    
    def get_usuarios_com_multas(self, conn: connection) -> Set['Usuario']:
        
        from model.usuario_model import Usuario

        lista_usuarios: Set[Usuario] = set()
        sql = """
            SELECT id_usuario, nome, telefone, endereco, categoria 
            FROM Usuario
            WHERE id_usuario IN (
                SELECT id_usuario FROM Emprestimo WHERE multas > 0
            )
        """
 
        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_usuarios.add(Usuario(
                    id_usuario = row[0],
                    nome = row[1],
                    telefone = row[2],
                    endereco = row[3],
                    categoria = row[4]
                ))
        return lista_usuarios
        
    def update_devolucao(self, id_emprestimo: int, data_devolucao: date, multas: Decimal, conn: connection) -> None:

        sql = "UPDATE Emprestimo SET data_devolucao_real = %s, multas = %s WHERE id_emprestimo = %s"
        params = (data_devolucao, multas, id_emprestimo)
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

    def update_renovacao(self, id_emprestimo: int, nova_data_prevista: date, conn: connection) -> None:

        sql = "UPDATE Emprestimo SET data_devolucao_prevista = %s, renovacoes = renovacoes + 1 WHERE id_emprestimo = %s"
        params = (nova_data_prevista, id_emprestimo)
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

    def get_emprestimo_ativo_by_usuario_e_livro(self, id_usuario: int, id_livro: int, conn: connection) -> Optional[int]:

        sql = """
            SELECT e.id_emprestimo
            FROM Emprestimo e
            JOIN Emprestimo_Exemplar ee ON e.id_emprestimo = ee.id_emprestimo
            JOIN Exemplar ex ON ee.id_exemplar = ex.id_exemplar
            WHERE e.id_usuario = %s 
              AND ex.id_livro = %s 
              AND e.data_devolucao_real IS NULL
            LIMIT 1
        """
        params = (id_usuario, id_livro)
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            row = cursor.fetchone()
            if row:
                return row[0]  # Retorna o id_emprestimo
            else:
                return None

    def get_tempo_emprestimo_por_usuario(self, usuario: 'Usuario', conn: connection) -> Optional[int]:
        from model.usuario_model import Usuario

        categoria = usuario.categoria 
        id_usuario = usuario.id_usuario
        sql = ""
        
        if categoria == 'aluno_grad':
            sql = "SELECT tempo_emprestimo FROM Aluno_Graduacao WHERE id_usuario = %s"
        elif categoria == 'aluno_pos':
            sql = "SELECT tempo_emprestimo FROM Aluno_PosGraduacao WHERE id_usuario = %s"
        elif categoria == 'professor':
            sql = "SELECT tempo_emprestimo FROM Professor WHERE id_usuario = %s"
        elif categoria == 'professor_pos':
            sql = "SELECT tempo_emprestimo FROM Professor_PosGraduacao WHERE id_usuario = %s"
        else:
            return None

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            row = cursor.fetchone()
            if row:
                return row[0] 
            else:
                return None
            
    def get_livros_emprestados_ativos(self, id_usuario: int, conn: connection) -> Set[LivroEmprestadoView]:

        lista_livros: Set[LivroEmprestadoView] = set()
        sql = """
            SELECT DISTINCT 
                l.id_livro, 
                l.titulo, 
                e.data_devolucao_prevista,
                e.id_emprestimo
            FROM Emprestimo e
            JOIN Emprestimo_Exemplar ee ON e.id_emprestimo = ee.id_emprestimo
            JOIN Exemplar ex ON ee.id_exemplar = ex.id_exemplar
            JOIN Livro l ON ex.id_livro = l.id_livro
            WHERE e.id_usuario = %s AND e.data_devolucao_real IS NULL
            ORDER BY e.data_devolucao_prevista
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            for row in cursor:
                lista_livros.add(LivroEmprestadoView(
                    id_livro=row[0],
                    titulo=row[1],
                    data_devolucao_prevista=row[2],
                    id_emprestimo=row[3]
                ))
        return lista_livros
    
    def list_atrasados_com_nomes(self, conn: connection) -> Set[tuple]:

        lista_atrasados: Set[tuple] = set()
        sql = """
            SELECT 
                e.id_emprestimo, 
                u.nome, 
                e.data_devolucao_prevista, 
                CURRENT_DATE - e.data_devolucao_prevista AS dias_atraso 
            FROM Emprestimo e 
            JOIN Usuario u ON e.id_usuario = u.id_usuario 
            WHERE e.data_devolucao_real IS NULL 
              AND e.data_devolucao_prevista < CURRENT_DATE
            ORDER BY dias_atraso DESC
        """

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_atrasados.add((
                    row[0],
                    row[1], 
                    row[2],
                    row[3]  
                ))
        return lista_atrasados
    
    def list_exemplares_emprestados_ativos_com_nomes(self, conn: connection) -> Set[tuple]:

        lista_ativos: Set[tuple] = set()
        sql = """
            SELECT
                ex.id_exemplar,
                l.titulo,
                u.nome
            FROM Emprestimo e
            JOIN Usuario u ON e.id_usuario = u.id_usuario
            JOIN Emprestimo_Exemplar ee ON e.id_emprestimo = ee.id_emprestimo
            JOIN Exemplar ex ON ee.id_exemplar = ex.id_exemplar
            JOIN Livro l ON ex.id_livro = l.id_livro
            WHERE e.data_devolucao_real IS NULL
            ORDER BY u.nome, l.titulo
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_ativos.add((
                    row[0], 
                    row[1], 
                    row[2]  
                ))
        return lista_ativos