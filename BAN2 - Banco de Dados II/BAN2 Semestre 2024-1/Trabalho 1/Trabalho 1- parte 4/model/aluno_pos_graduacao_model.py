import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from model.usuario_model import Usuario

@dataclass(eq=True)
class AlunoPosGraduacao(Usuario):
    quantidade_limite_emprestimos: int
    tempo_emprestimo: int
    
class AlunoPosGraduacaoModel:

    def create(self, aluno: AlunoPosGraduacao, conn: connection) -> int:
        
        if aluno.categoria != 'aluno_pos':
            raise ValueError("A categoria do objeto AlunoPosGraduacao deve ser 'aluno_pos'")

        sql_usuario = """
            INSERT INTO Usuario(nome, telefone, endereco, categoria) 
            VALUES (%s, %s, %s, %s)
            RETURNING id_usuario
        """
        params_usuario = (
            aluno.nome,
            aluno.telefone,
            aluno.endereco,
            aluno.categoria
        )
        
        sql_aluno = """
            INSERT INTO Aluno_PosGraduacao(id_usuario, quantidade_limite_emprestimos, tempo_emprestimo)
            VALUES (%s, %s, %s)
        """
        
        novo_id = None

        with conn.cursor() as cursor:
            cursor.execute(sql_usuario, params_usuario)
            novo_id = cursor.fetchone()[0]
                
            params_aluno = (
                novo_id, 
                aluno.quantidade_limite_emprestimos, 
                aluno.tempo_emprestimo
            )
            cursor.execute(sql_aluno, params_aluno)
                 
            return novo_id
            
    def get_by_id(self, id_usuario: int, conn: connection) -> Optional[AlunoPosGraduacao]:

        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   a.quantidade_limite_emprestimos, a.tempo_emprestimo
            FROM Usuario u
            JOIN Aluno_PosGraduacao a ON u.id_usuario = a.id_usuario
            WHERE u.id_usuario = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            row = cursor.fetchone()
                
            if row:
                return AlunoPosGraduacao(
                    id_usuario=row[0],
                    nome=row[1],
                    telefone=row[2],
                    endereco=row[3],
                    categoria=row[4],
                    quantidade_limite_emprestimos=row[5],
                    tempo_emprestimo=row[6]
                )
            else:
                return None

    def update(self, aluno: AlunoPosGraduacao, conn: connection) -> None:

        if aluno.id_usuario is None:
            raise ValueError("ID do aluno não pode ser None para atualização.")

        sql_usuario = """
            UPDATE Usuario 
            SET nome = %s, telefone = %s, endereco = %s, categoria = %s 
            WHERE id_usuario = %s
        """
        params_usuario = (
            aluno.nome,
            aluno.telefone,
            aluno.endereco,
            aluno.categoria,
            aluno.id_usuario
        )
        
        sql_aluno = """
            UPDATE Aluno_PosGraduacao
            SET quantidade_limite_emprestimos = %s, tempo_emprestimo = %s
            WHERE id_usuario = %s
        """
        params_aluno = (
            aluno.quantidade_limite_emprestimos,
            aluno.tempo_emprestimo,
            aluno.id_usuario
        )

        with conn.cursor() as cursor:
            cursor.execute(sql_usuario, params_usuario)
            cursor.execute(sql_aluno, params_aluno)
            
    def list_all(self, conn: connection) -> Set[AlunoPosGraduacao]:

        lista_alunos: Set[AlunoPosGraduacao] = set()
        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   a.quantidade_limite_emprestimos, a.tempo_emprestimo
            FROM Usuario u
            JOIN Aluno_PosGraduacao a ON u.id_usuario = a.id_usuario
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_alunos.add(AlunoPosGraduacao(
                    id_usuario=row[0],
                    nome=row[1],
                    telefone=row[2],
                    endereco=row[3],
                    categoria=row[4],
                    quantidade_limite_emprestimos=row[5],
                    tempo_emprestimo=row[6]
                ))

        return lista_alunos