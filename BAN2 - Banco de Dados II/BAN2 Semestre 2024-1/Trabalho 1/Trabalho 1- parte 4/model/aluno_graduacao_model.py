import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from model.usuario_model import Usuario

@dataclass(eq=True)
class AlunoGraduacao(Usuario):
    quantidade_limite_emprestimos: int
    tempo_emprestimo: int
    
class AlunoGraduacaoModel:

    def create(self, aluno: AlunoGraduacao, conn: connection) -> int:
        
        if aluno.categoria != 'aluno_grad':
            raise ValueError("A categoria do objeto AlunoGraduacao deve ser 'aluno_grad'")

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
            INSERT INTO Aluno_Graduacao(id_usuario, quantidade_limite_emprestimos, tempo_emprestimo)
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
            
    def get_by_id(self, id_usuario: int, conn: connection) -> Optional[AlunoGraduacao]:

        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   a.quantidade_limite_emprestimos, a.tempo_emprestimo
            FROM Usuario u
            JOIN Aluno_Graduacao a ON u.id_usuario = a.id_usuario
            WHERE u.id_usuario = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            row = cursor.fetchone()
                
            if row:
                return AlunoGraduacao(
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

    def update(self, aluno: AlunoGraduacao, conn: connection) -> None:

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
            UPDATE Aluno_Graduacao
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
            
            
    def list_all(self, conn: connection) -> Set[AlunoGraduacao]:

        lista_alunos: Set[AlunoGraduacao] = set()
        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   a.quantidade_limite_emprestimos, a.tempo_emprestimo
            FROM Usuario u
            JOIN Aluno_Graduacao a ON u.id_usuario = a.id_usuario
        """
        

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_alunos.add(AlunoGraduacao(
                    id_usuario=row[0],
                    nome=row[1],
                    telefone=row[2],
                    endereco=row[3],
                    categoria=row[4],
                    quantidade_limite_emprestimos=row[5],
                    tempo_emprestimo=row[6]
                ))
            
        return lista_alunos