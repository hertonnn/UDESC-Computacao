import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from model.autor_model import Autor
from model.editora_model import Editora


@dataclass(frozen=True, eq=True)
class Livro:
    titulo: str
    isbn: Optional[str] = None
    id_colecao: Optional[int] = None
    id_livro: Optional[int] = None

class LivroModel:

    def create(self, livro: Livro, conn: connection) -> int:

        sql = """
            INSERT INTO Livro(titulo, ISBN, id_colecao) 
            VALUES (%s, %s, %s)
            RETURNING id_livro
        """
        params = (livro.titulo, livro.isbn, livro.id_colecao)

        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]

        return novo_id

    def get_by_id(self, id_livro: int, conn: connection) -> Optional[Livro]:

        sql = """
            SELECT id_livro, titulo, ISBN, id_colecao 
            FROM Livro 
            WHERE id_livro = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro,))
            row = cursor.fetchone()
                
            if row:
                return Livro(
                    id_livro=row[0],
                    titulo=row[1],
                    isbn=row[2],
                    id_colecao=row[3]
                )
            else:
                return None

    def search_livro_by_titulo(self, termo_busca: str, conn: connection) -> Set[Livro]:

        lista_livros: Set[Livro] = set()
        sql = """
            SELECT id_livro, titulo, ISBN, id_colecao 
            FROM Livro 
            WHERE titulo ILIKE %s
        """
        params = (f"%{termo_busca}%",)


        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            for row in cursor:
                lista_livros.add(Livro(
                    id_livro=row[0],
                    titulo=row[1],
                    isbn=row[2],
                    id_colecao=row[3]
                ))

        return lista_livros

    def search_livro_by_isbn(self, isbn: str, conn: connection) -> Optional[Livro]:

        sql = """
            SELECT id_livro, titulo, ISBN, id_colecao 
            FROM Livro 
            WHERE ISBN = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (isbn,))
            row = cursor.fetchone()
                
            if row:
                return Livro(
                    id_livro=row[0],
                    titulo=row[1],
                    isbn=row[2],
                    id_colecao=row[3]
                )
            else:
                return None

    def list_all_livros(self, conn: connection) -> Set[Livro]:

        lista_livros: Set[Livro] = set()
        sql = "SELECT id_livro, titulo, ISBN, id_colecao FROM Livro"


        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_livros.add(Livro(
                    id_livro=row[0],
                    titulo=row[1],
                    isbn=row[2],
                    id_colecao=row[3]
                ))

        return lista_livros

    def update_livro(self, livro: Livro, conn: connection) -> None:

        if livro.id_livro is None:
            raise ValueError("ID do livro não pode ser None para atualização.")
            
        sql = """
            UPDATE Livro 
            SET titulo = %s, 
                ISBN = %s, 
                id_colecao = %s 
            WHERE id_livro = %s
        """
        params = (
            livro.titulo,
            livro.isbn,
            livro.id_colecao,
            livro.id_livro
        )
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

    def remove_livro(self, id_livro: int, conn: connection) -> None:
 
        sql_livro = "DELETE FROM Livro WHERE id_livro = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql_livro, (id_livro,))

    def add_autor_to_livro(self, id_livro: int, id_autor: int, conn: connection) -> None:
        
        sql = "INSERT INTO Autoria(id_livro, id_autor) VALUES (%s, %s)"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro, id_autor))

    def remove_autor_from_livro(self, id_livro: int, id_autor: int, conn: connection) -> None:

        sql = "DELETE FROM Autoria WHERE id_livro = %s AND id_autor = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro, id_autor))

    def get_autores_of_livro(self, id_livro: int, conn: connection) -> Set[Autor]:

        lista_autores: Set[Autor] = set()
        sql = """
            SELECT a.id_autor, a.nome 
            FROM Autor a 
            JOIN Autoria au ON a.id_autor = au.id_autor 
            WHERE au.id_livro = %s
        """
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro,))
            for row in cursor:
                lista_autores.add(Autor(
                    id_autor=row[0],
                    nome=row[1]
                ))

        return lista_autores

    def add_editora_to_livro(self, id_livro: int, id_editora: int, conn: connection) -> None:

        sql = "INSERT INTO Edicao(id_livro, id_editora) VALUES (%s, %s)"
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro, id_editora))

    def remove_editora_from_livro(self, id_livro: int, id_editora: int, conn: connection) -> None:

        sql = "DELETE FROM Edicao WHERE id_livro = %s AND id_editora = %s"
        with conn.cursor() as cursor:
                cursor.execute(sql, (id_livro, id_editora))

    def get_editoras_of_livro(self, id_livro: int, conn: connection) -> Set[Editora]:

        lista_editoras: Set[Editora] = set()
        sql = """
            SELECT e.id_editora, e.nome 
            FROM Editora e 
            JOIN Edicao ed ON e.id_editora = ed.id_editora 
            WHERE ed.id_livro = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_livro,))
            for row in cursor:
                lista_editoras.add(Editora(
                    id_editora=row[0],
                    nome=row[1]
                ))
                
        return lista_editoras