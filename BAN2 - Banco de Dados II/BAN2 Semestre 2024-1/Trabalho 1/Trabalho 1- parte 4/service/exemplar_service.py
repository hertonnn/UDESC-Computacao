from typing import List, Optional
from psycopg2.extensions import connection
from model.exemplar_model import ExemplarModel, Exemplar, ExemplarView

class ExemplarService:
    def __init__(self, conn: connection):
        self.conn = conn
        self.exemplar_model = ExemplarModel()

    def adicionar_exemplar(self, id_livro: int, numero_exemplar: int, 
                          is_colecao_reservada: bool = False) -> int:
        """Adiciona um novo exemplar ao sistema."""
        try:
            novo_id = self.exemplar_model.create_exemplar(
                id_livro=id_livro,
                numero_exemplar=numero_exemplar,
                conn=self.conn,
                is_colecao_reservada=is_colecao_reservada
            )
            self.conn.commit()
            return novo_id
        except Exception as e:
            self.conn.rollback()
            raise e

    def listar_exemplares(self, id_livro: Optional[int] = None) -> List[ExemplarView]:
        """Lista todos os exemplares, opcionalmente filtrados por livro."""
        with self.conn.cursor() as cursor:
            if id_livro:
                sql = """
                    SELECT e.id_exemplar, e.numero_exemplar, e.situacao, 
                           e.is_colecao_reservada, e.id_livro, l.titulo
                    FROM Exemplar e
                    JOIN Livro l ON e.id_livro = l.id_livro
                    WHERE e.id_livro = %s
                    ORDER BY e.numero_exemplar
                """
                cursor.execute(sql, (id_livro,))
            else:
                sql = """
                    SELECT e.id_exemplar, e.numero_exemplar, e.situacao, 
                           e.is_colecao_reservada, e.id_livro, l.titulo
                    FROM Exemplar e
                    JOIN Livro l ON e.id_livro = l.id_livro
                    ORDER BY l.titulo, e.numero_exemplar
                """
                cursor.execute(sql)
            
            return [
                ExemplarView(
                    id_exemplar=row[0],
                    numero_exemplar=row[1],
                    situacao=row[2],
                    is_colecao_reservada=row[3],
                    id_livro=row[4],
                    titulo_livro=row[5]
                )
                for row in cursor.fetchall()
            ]

    def buscar_proximo_numero_exemplar(self, id_livro: int) -> int:
        """Busca o próximo número disponível para um novo exemplar do livro."""
        with self.conn.cursor() as cursor:
            sql = """
                SELECT COALESCE(MAX(numero_exemplar), 0) + 1
                FROM Exemplar
                WHERE id_livro = %s
            """
            cursor.execute(sql, (id_livro,))
            return cursor.fetchone()[0]

    def verificar_livro_existe(self, id_livro: int) -> bool:
        """Verifica se um livro existe antes de adicionar exemplares."""
        with self.conn.cursor() as cursor:
            cursor.execute("SELECT 1 FROM Livro WHERE id_livro = %s", (id_livro,))
            return cursor.fetchone() is not None