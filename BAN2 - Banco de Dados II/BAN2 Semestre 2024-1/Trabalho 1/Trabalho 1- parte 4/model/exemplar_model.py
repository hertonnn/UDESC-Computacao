import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set

@dataclass(frozen=True, eq=True)
class Exemplar:
    numero_exemplar: int
    situacao: str
    is_colecao_reservada: bool
    id_livro: int
    id_exemplar: Optional[int] = None

@dataclass(frozen=True, eq=True)
class ExemplarView:
    id_exemplar: int
    numero_exemplar: int
    situacao: str
    is_colecao_reservada: bool
    id_livro: int
    titulo_livro: str


class ExemplarModel:

    def create_exemplar(self, 
                        id_livro: int, 
                        numero_exemplar: int, 
                        conn: connection,
                        situacao_inicial: str = 'disponível', 
                        is_colecao_reservada: bool = False
                        ) -> int:

        sql = """
            INSERT INTO Exemplar(numero_exemplar, situacao, is_colecao_reservada, id_livro) 
            VALUES (%s, %s, %s, %s)
            RETURNING id_exemplar
        """
        params = (
            numero_exemplar, 
            situacao_inicial, 
            is_colecao_reservada, 
            id_livro
        )

        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]

        return novo_id

    def get_exemplar_by_id(self, id_exemplar: int, conn: connection) -> Optional[ExemplarView]:

        sql = """
            SELECT 
                e.id_exemplar, e.numero_exemplar, e.situacao, 
                e.is_colecao_reservada, e.id_livro, 
                l.titulo AS titulo_livro
            FROM Exemplar e
            JOIN Livro l ON e.id_livro = l.id_livro
            WHERE e.id_exemplar = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_exemplar,))
            row = cursor.fetchone()
                
            if row:
                return ExemplarView(
                    id_exemplar=row[0],
                    numero_exemplar=row[1],
                    situacao=row[2],
                    is_colecao_reservada=row[3],
                    id_livro=row[4],
                    titulo_livro=row[5]
                )
            else:
                return None

    def list_exemplares_of_livro(self, id_livro: int, conn: connection) -> Set[Exemplar]:

        lista_exemplares: Set[Exemplar] = set()
        sql = """
            SELECT id_exemplar, numero_exemplar, situacao, 
                   is_colecao_reservada, id_livro 
            FROM Exemplar 
            WHERE id_livro = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro,))
            for row in cursor:
                lista_exemplares.add(Exemplar(
                    id_exemplar=row[0],
                    numero_exemplar=row[1],
                    situacao=row[2],
                    is_colecao_reservada=row[3],
                    id_livro=row[4]
                ))
        return lista_exemplares

    def update_situacao(self, id_exemplar: int, nova_situacao: str, conn: connection) -> None:
 
        sql = "UPDATE Exemplar SET situacao = %s WHERE id_exemplar = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (nova_situacao, id_exemplar))

    def update_colecao_reservada_status(self, id_exemplar: int, status_booleano: bool, conn: connection) -> None:

        sql = "UPDATE Exemplar SET is_colecao_reservada = %s WHERE id_exemplar = %s"
        with conn.cursor() as cursor:
            cursor.execute(sql, (status_booleano, id_exemplar))

    def get_situacao(self, id_exemplar: int, conn: connection) -> Optional[str]:

        sql = "SELECT situacao FROM Exemplar WHERE id_exemplar = %s"
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_exemplar,))
            row = cursor.fetchone()
            return row[0] if row else None


    def check_disponibilidade(self, id_exemplar: int, conn: connection) -> bool:

        situacao = self.get_situacao(id_exemplar, conn)
        return situacao == 'disponível'
