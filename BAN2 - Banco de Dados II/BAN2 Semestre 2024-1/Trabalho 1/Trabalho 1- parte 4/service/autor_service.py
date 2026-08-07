from model.autor_model import AutorModel, Autor
from psycopg2.extensions import connection

class AutorService:
    def __init__(self, conn: connection):
        self.conn = conn
        self.autor_model = AutorModel()

    def criar_autor(self, nome: str) -> int:
        """Creates a new author and returns their ID"""
        autor = Autor(nome=nome, id_autor=None)
        try:
            novo_id = self.autor_model.create(autor, self.conn)
            self.conn.commit()
            return novo_id
        except Exception as e:
            self.conn.rollback()
            raise e

    def remover_autor(self, id_autor: int) -> None:
        """Removes an author by ID"""
        try:
            self.autor_model.remove(id_autor, self.conn)
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            raise e

    def listar_autores(self) -> list[Autor]:
        """Returns a list of all authors"""
        try:
            autores = self.autor_model.list_all(self.conn)
            return sorted(list(autores), key=lambda x: x.nome)
        except Exception as e:
            self.conn.rollback()
            raise e