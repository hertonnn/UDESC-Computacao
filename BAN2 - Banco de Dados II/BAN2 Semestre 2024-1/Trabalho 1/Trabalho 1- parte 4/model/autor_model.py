import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set

@dataclass(frozen=True, eq=True)
class Autor:
    nome: str
    id_autor: Optional[int] = None

class AutorModel:

    def create(self, autor: Autor, conn: connection) -> int:

        sql = """
            INSERT INTO Autor(nome) 
            VALUES (%s)
            RETURNING id_autor
        """

        params = (autor.nome, )

        with conn.cursor() as cursor:
            cursor.execute(sql, params, )
            novo_id = cursor.fetchone()[0]

        return novo_id
    
    def remove(self, id_autor: int, conn: connection) -> None:

        sql = "DELETE FROM Autor WHERE id_autor = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_autor,))

    def list_all(self, conn: connection) -> Set[Autor]:

        lista_autores: Set[Autor] = set()
        sql = "SELECT id_autor, nome FROM autor"

        with conn.cursor() as cursor:
            cursor.execute(sql)

            for row in cursor:
                lista_autores.add(Autor(
                    id_autor = row[0],
                    nome = row[1],
                ))

        return lista_autores
    
    def get_by_id(self, id_autor: int, conn: connection) -> Optional[Autor]:

        sql = """
            SELECT id_autor, nome
            FROM Autor
            WHERE id_autor = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_autor,))
                
            row = cursor.fetchone() 
                
            if row:
                return Autor(
                    id_autor = row[0],
                    nome = row[1],
                )
            else:
                return None

def update(self, autor: Autor, conn: connection) -> None:
    
    if autor.id_autor is None:
        raise ValueError("ID do autor não pode ser None para atualização.")

    sql = """
        UPDATE Autor 
        SET nome = %s
        WHERE id_autor = %s
        """

    params = (
        autor.nome, 
        autor.id_autor
        )

    with conn.cursor() as cursor:
        cursor.execute(sql, params)
