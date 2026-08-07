import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set

@dataclass(frozen=True, eq=True)
class Bibliotecario:
    nome: str
    cpf: str
    cargo: str  
    id_bibliotecario: Optional[int] = None

class BibliotecarioModel:

    def create(self, bibliotecario: Bibliotecario, conn: connection) -> int:

        sql = """
            INSERT INTO Bibliotecario(nome, cpf, cargo) 
            VALUES (%s, %s, %s)
            RETURNING id_bibliotecario
        """
        params = (bibliotecario.nome, bibliotecario.cpf, bibliotecario.cargo)
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]
            return novo_id


    def remove(self, id_bibliotecario: int, conn: connection) -> None:

        sql = "DELETE FROM Bibliotecario WHERE id_bibliotecario = %s"
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_bibliotecario,))


    def list_all(self, conn: connection) -> Set[Bibliotecario]:

        lista_bibliotecarios: Set[Bibliotecario] = set()
        sql = "SELECT id_bibliotecario, nome, cpf, cargo FROM Bibliotecario"

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_bibliotecarios.add(Bibliotecario(
                    id_bibliotecario=row[0],
                    nome=row[1],
                    cpf=row[2],
                    cargo=row[3]
                ))

        return lista_bibliotecarios

    def get_by_id(self, id_bibliotecario: int, conn: connection) -> Optional[Bibliotecario]:

        sql = "SELECT id_bibliotecario, nome, cpf, cargo FROM Bibliotecario WHERE id_bibliotecario = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_bibliotecario,))
            row = cursor.fetchone()
            if row:
                return Bibliotecario(
                    id_bibliotecario=row[0],
                    nome=row[1],
                    cpf=row[2],
                    cargo=row[3]
                )
            else:
                return None
            
    def get_by_cpf(self, cpf: str, conn: connection) -> Optional[Bibliotecario]:

        sql = "SELECT id_bibliotecario, nome, cpf, cargo FROM Bibliotecario WHERE cpf = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (cpf,))
            row = cursor.fetchone()
            if row:
                return Bibliotecario(
                    id_bibliotecario=row[0],
                    nome=row[1],
                    cpf=row[2],
                    cargo=row[3]
                )
            else:
                return None

    def update(self, bibliotecario: Bibliotecario, conn: connection) -> None:

        if bibliotecario.id_bibliotecario is None:
            raise ValueError("ID do bibliotecário não pode ser None para atualização.")
            
        sql = """
            UPDATE Bibliotecario 
            SET nome = %s,
                cpf = %s,
                cargo = %s
            WHERE id_bibliotecario = %s
        """
        params = (
            bibliotecario.nome, 
            bibliotecario.cpf, 
            bibliotecario.cargo, 
            bibliotecario.id_bibliotecario
        )
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

@dataclass(frozen=True, eq=True)
class Assistente:
    nome: str
    cpf: str
    id_bibliotecario: Optional[int]  
    id_assistente: Optional[int] = None

class AssistenteModel:

    def create(self, assistente: Assistente, conn: connection) -> int:

        sql = """
            INSERT INTO Assistente(nome, cpf, id_bibliotecario) 
            VALUES (%s, %s, %s)
            RETURNING id_assistente
        """
        params = (assistente.nome, assistente.cpf, assistente.id_bibliotecario)
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]
            return novo_id

    def remove(self, id_assistente: int, conn: connection) -> None:

        sql = "DELETE FROM Assistente WHERE id_assistente = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_assistente,))


    def list_all(self, conn: connection) -> Set[Assistente]:

        lista_assistentes: Set[Assistente] = set()
        sql = "SELECT id_assistente, nome, cpf, id_bibliotecario FROM Assistente"

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_assistentes.add(Assistente(
                    id_assistente=row[0],
                    nome=row[1],
                    cpf=row[2],
                    id_bibliotecario=row[3]
                ))

        return lista_assistentes

    def get_by_id(self, id_assistente: int, conn: connection) -> Optional[Assistente]:

        sql = "SELECT id_assistente, nome, cpf, id_bibliotecario FROM Assistente WHERE id_assistente = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_assistente,))
            row = cursor.fetchone()
            if row:
                return Assistente(
                    id_assistente=row[0],
                    nome=row[1],
                    cpf=row[2],
                    id_bibliotecario=row[3]
                )
            else:
                return None

    def get_by_cpf(self, cpf: str, conn: connection) -> Optional[Assistente]:

        sql = "SELECT id_assistente, nome, cpf, id_bibliotecario FROM Assistente WHERE cpf = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (cpf,))
            row = cursor.fetchone()
            if row:
                return Assistente(
                    id_assistente=row[0],
                    nome=row[1],
                    cpf=row[2],
                    id_bibliotecario=row[3]
                )
            else:
                return None
            
    def update(self, assistente: Assistente, conn: connection) -> None:

        if assistente.id_assistente is None:
            raise ValueError("ID do assistente não pode ser None para atualização.")
            
        sql = """
            UPDATE Assistente 
            SET nome = %s,
                cpf = %s,
                id_bibliotecario = %s
            WHERE id_assistente = %s
        """
        params = (
            assistente.nome, 
            assistente.cpf, 
            assistente.id_bibliotecario, 
            assistente.id_assistente
        )
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)

