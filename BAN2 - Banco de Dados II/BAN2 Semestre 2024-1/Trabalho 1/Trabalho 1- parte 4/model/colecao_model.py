import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set

@dataclass(frozen=True, eq=True)
class Colecao:

    nome: str
    id_colecao: Optional[int] = None

class ColecaoModel:

    def create(self, colecao: Colecao, conn: connection) -> int:

        sql = """
            INSERT INTO Colecao(nome) 
            VALUES (%s)
            RETURNING id_colecao
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (colecao.nome,))
            novo_id = cursor.fetchone()[0]

            return novo_id

    def remove(self, id_colecao: int, conn: connection) -> None:

        sql = "DELETE FROM Colecao WHERE id_colecao = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_colecao,))

    def list_all(self, conn: connection) -> Set[Colecao]:

        lista_colecoes: Set[Colecao] = set()
        sql = "SELECT id_colecao, nome FROM Colecao"


        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_colecoes.add(Colecao(
                    id_colecao=row[0],
                    nome=row[1]
                ))

        return lista_colecoes

    def get_by_id(self, id_colecao: int, conn: connection) -> Optional[Colecao]:

        sql = "SELECT id_colecao, nome FROM Colecao WHERE id_colecao = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_colecao,))
            row = cursor.fetchone()
            if row:
                return Colecao(
                    id_colecao=row[0],
                    nome=row[1]
                )
            else:
                return None

    def update(self, colecao: Colecao, conn: connection) -> None:

        if colecao.id_colecao is None:
            raise ValueError("ID da coleção não pode ser None para atualização.")
            
        sql = """
            UPDATE Colecao 
            SET nome = %s
            WHERE id_colecao = %s
        """
        params = (colecao.nome, colecao.id_colecao)
        

        with conn.cursor() as cursor:
            cursor.execute(sql, params)