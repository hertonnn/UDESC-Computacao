import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from model.usuario_model import Usuario 


@dataclass(eq=True)
class ProfessorPos(Usuario):
    tipo_contrato: str
    quantidade_limite_emprestimos: int
    tempo_emprestimo: int

class ProfessorPosModel:

    def create(self, professor: ProfessorPos, conn: connection) -> int:

        if professor.categoria != 'professor_pos':
            raise ValueError("A categoria do objeto ProfessorPos deve ser 'professor_pos'")

        sql_usuario = """
            INSERT INTO Usuario(nome, telefone, endereco, categoria) 
            VALUES (%s, %s, %s, %s)
            RETURNING id_usuario
        """
        params_usuario = (
            professor.nome,
            professor.telefone,
            professor.endereco,
            professor.categoria
        )
        
        sql_professor = """
            INSERT INTO Professor_PosGraduacao(id_usuario, tipo_contrato, quantidade_limite_emprestimos, tempo_emprestimo)
            VALUES (%s, %s, %s, %s)
        """
        
        novo_id = None

        with conn.cursor() as cursor:
            cursor.execute(sql_usuario, params_usuario)
            novo_id = cursor.fetchone()[0]
                
            params_professor = (
                novo_id, 
                professor.tipo_contrato,
                professor.quantidade_limite_emprestimos, 
                professor.tempo_emprestimo
            )
            cursor.execute(sql_professor, params_professor)
                
        return novo_id
            
    def get_by_id(self, id_usuario: int, conn: connection) -> Optional[ProfessorPos]:

        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   p.tipo_contrato, p.quantidade_limite_emprestimos, p.tempo_emprestimo
            FROM Usuario u
            JOIN Professor_PosGraduacao  p ON u.id_usuario = p.id_usuario
            WHERE u.id_usuario = %s
        """

        with conn.cursor() as cursor:
            cursor.execute(sql, (id_usuario,))
            row = cursor.fetchone()
                
            if row:
                return ProfessorPos(
                    id_usuario=row[0],
                    nome=row[1],
                    telefone=row[2],
                    endereco=row[3],
                    categoria=row[4],
                    tipo_contrato=row[5],
                    quantidade_limite_emprestimos=row[6],
                    tempo_emprestimo=row[7]
                )
            else:
                return None

    def update(self, professor: ProfessorPos, conn: connection) -> None:

        if professor.id_usuario is None:
            raise ValueError("ID do professor Pós não pode ser None para atualização.")

        sql_usuario = """
            UPDATE Usuario 
            SET nome = %s, telefone = %s, endereco = %s, categoria = %s 
            WHERE id_usuario = %s
        """
        params_usuario = (
            professor.nome,
            professor.telefone,
            professor.endereco,
            professor.categoria,
            professor.id_usuario
        )
        
        sql_professor = """
            UPDATE Professor_PosGraduacao 
            SET tipo_contrato = %s, quantidade_limite_emprestimos = %s, tempo_emprestimo = %s
            WHERE id_usuario = %s
        """
        params_professor = (
            professor.tipo_contrato,
            professor.quantidade_limite_emprestimos,
            professor.tempo_emprestimo,
            professor.id_usuario
        )

        with conn.cursor() as cursor:
            cursor.execute(sql_usuario, params_usuario)
            cursor.execute(sql_professor, params_professor)
                  
    def list_all(self, conn: connection) -> Set[ProfessorPos]:

        lista_professores: Set[ProfessorPos] = set()
        sql = """
            SELECT u.id_usuario, u.nome, u.telefone, u.endereco, u.categoria,
                   p.tipo_contrato, p.quantidade_limite_emprestimos, p.tempo_emprestimo
            FROM Usuario u
            JOIN Professor_PosGraduacao p ON u.id_usuario = p.id_usuario
            ORDER BY u.nome
        """

        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_professores.add(ProfessorPos(
                    id_usuario=row[0],
                    nome=row[1],
                    telefone=row[2],
                    endereco=row[3],
                    categoria=row[4],
                    tipo_contrato=row[5],
                    quantidade_limite_emprestimos=row[6],
                    tempo_emprestimo=row[7]
                ))
            
        return lista_professores