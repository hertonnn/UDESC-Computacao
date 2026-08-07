import psycopg2
from psycopg2.extensions import connection
from typing import Optional, Set
from datetime import date
from decimal import Decimal
from model.reserva_model import Reserva

class Usuario:

    def __init__(self, 
                 nome: str, 
                 telefone: str, 
                 endereco: str, 
                 categoria: str, 
                 id_usuario: Optional[int] = None): 
        
        self.nome = nome
        self.telefone = telefone
        self.endereco = endereco
        self.categoria = categoria
        self.id_usuario = id_usuario


    def __eq__(self, other):
        if not isinstance(other, Usuario):
            return False
        if self.id_usuario is not None and other.id_usuario is not None:
            return self.id_usuario == other.id_usuario

        return (self.nome, self.telefone) == (other.nome, other.telefone)

    def __hash__(self):
        if self.id_usuario is not None:
            return hash(self.id_usuario)
        return hash((self.nome, self.telefone))

class UsuarioModel:

    def create(self, usuario: Usuario, conn: connection) -> int:

        sql = """
            INSERT INTO Usuario(nome, telefone, endereco, categoria) 
            VALUES (%s, %s, %s, %s)
            RETURNING id_usuario
        """

        params = (
            usuario.nome,
            usuario.telefone,
            usuario.endereco,
            usuario.categoria 
        )

        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]
        return novo_id
    
    def remove(self, id_usuario: int, conn: connection) -> None:

        sql = "DELETE FROM Usuario WHERE id_usuario = %s"

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))

    def list_all(self, conn: connection) -> Set[Usuario]:

        lista_usuarios: Set[Usuario] = set()
        sql = "SELECT id_usuario, nome, telefone, endereco, categoria FROM Usuario"

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
    
    def get_by_id(self, id_usuario: int, conn: connection) -> Optional[Usuario]:

        sql = """
            SELECT id_usuario, nome, telefone, endereco, categoria 
            FROM Usuario 
            WHERE id_usuario = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
                
            row = cursor.fetchone() 
                
            if row:
                return Usuario(
                    id_usuario = row[0],
                    nome = row[1],
                    telefone = row[2],
                    endereco = row[3],
                    categoria = row[4]
                )
            else:
                return None
            
    def get_by_nome(self, nome: str, conn: connection) -> Optional[Usuario]:

        sql = """
            SELECT id_usuario, nome, telefone, endereco, categoria 
            FROM Usuario 
            WHERE nome = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (nome,))
                
            row = cursor.fetchone() 
                
            if row:
                return Usuario(
                    id_usuario = row[0],
                    nome = row[1],
                    telefone = row[2],
                    endereco = row[3],
                    categoria = row[4]
                )
            else:
                return None
            
    def get_by_nome_parcial(self, nome: str, conn: connection) -> Set[Usuario]:

        usuarios = set()
        sql = """
            SELECT id_usuario, nome, telefone, endereco, categoria 
            FROM Usuario 
            WHERE nome ILIKE %s
            ORDER BY nome
        """
        
        termo_busca_like = f"%{nome}%" 
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (termo_busca_like,))
            rows = cursor.fetchall()
            for row in rows:
                usuarios.add(Usuario(
                    id_usuario=row[0], 
                    nome=row[1], 
                    telefone=row[2], 
                    endereco=row[3], 
                    categoria=row[4]
                ))
        return usuarios

    def update(self, usuario: Usuario, conn: connection) -> None:
        
        sql = """
            UPDATE Usuario 
            SET nome = %s, 
                telefone = %s, 
                endereco = %s, 
                categoria = %s 
            WHERE id_usuario = %s
        """

        params = (
            usuario.nome,
            usuario.telefone,
            usuario.endereco,
            usuario.categoria,
            usuario.id_usuario 
        )
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)


    def get_emprestimos_ativos_by_usuario(self, id_usuario: int, conn: connection) -> Set['Emprestimo']:
        from model.emprestimo_model import Emprestimo

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

    def get_reservas_ativas_by_usuario(self, id_usuario: int, conn: connection) -> Set[Reserva]:

        lista_reservas: Set[Reserva] = set()
        sql = """
            SELECT id_reserva, data_reserva, situacao, id_usuario, id_exemplar
            FROM Reserva 
            WHERE id_usuario = %s AND situacao = 'ativa'
        """
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            for row in cursor:
                lista_reservas.add(Reserva(
                    id_reserva=row[0],
                    data_reserva=row[1],
                    situacao=row[2],
                    id_usuario=row[3],
                    id_exemplar=row[4]
                ))

        return lista_reservas

