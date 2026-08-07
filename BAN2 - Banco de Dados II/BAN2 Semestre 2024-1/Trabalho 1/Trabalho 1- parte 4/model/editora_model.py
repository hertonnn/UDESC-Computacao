import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set

@dataclass(frozen=True, eq=True)
class Editora:
    nome: str
    id_editora: Optional[int] = None

class EditoraModel:

    def create(self, editora: Editora, conn: connection) -> int:

        sql = """
            INSERT INTO Editora(nome) 
            VALUES (%s)
            RETURNING id_editora
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (editora.nome,))
            novo_id = cursor.fetchone()[0]
            return novo_id

    def remove(self, id_editora: int, conn: connection) -> None:

        sql = "DELETE FROM Editora WHERE id_editora = %s"
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_editora,))

    def list_all(self, conn: connection) -> Set[Editora]:

        lista_editoras: Set[Editora] = set()
        sql = "SELECT id_editora, nome FROM Editora"

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_editoras.add(Editora(
                    id_editora=row[0],
                    nome=row[1]
                ))

        return lista_editoras

    def get_by_id(self, id_editora: int, conn: connection) -> Optional[Editora]:

        sql = "SELECT id_editora, nome FROM Editora WHERE id_editora = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_editora,))
            row = cursor.fetchone()
            if row:
                return Editora(
                    id_editora=row[0],
                    nome=row[1]
                )
            else:
                return None

    def update(self, editora: Editora, conn: connection) -> None:

        if editora.id_editora is None:
            raise ValueError("ID da editora não pode ser None para atualização.")
            
        sql = """
            UPDATE Editora 
            SET nome = %s
            WHERE id_editora = %s
        """
        params = (editora.nome, editora.id_editora)
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

