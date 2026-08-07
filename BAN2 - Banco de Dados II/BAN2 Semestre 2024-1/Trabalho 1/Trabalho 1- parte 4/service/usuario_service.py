import psycopg2
from psycopg2.extensions import connection
from typing import Set, Union, Any

import exceptions 

from model.usuario_model import Usuario, UsuarioModel
from model.aluno_graduacao_model import AlunoGraduacao, AlunoGraduacaoModel
from model.aluno_pos_graduacao_model import AlunoPosGraduacao, AlunoPosGraduacaoModel
from model.professor_model import Professor, ProfessorModel
from model.professor_pos_model import ProfessorPos, ProfessorPosModel
from model.staff_model import Bibliotecario, BibliotecarioModel, Assistente, AssistenteModel
from model.emprestimo_model import EmprestimoModel 

class UsuarioService:

    def __init__(self, conn: connection):

        self.conn = conn
        self.usuario_model = UsuarioModel()
        self.aluno_grad_model = AlunoGraduacaoModel()
        self.aluno_pos_grad_model = AlunoPosGraduacaoModel()
        self.professor_model = ProfessorModel()
        self.professor_pos_model = ProfessorPosModel()
        self.bibliotecario_model = BibliotecarioModel()
        self.assistente_model = AssistenteModel()
        self.emprestimo_model = EmprestimoModel()

    def autenticar_staff(self, cpf: str) -> int:

        try: 

            bibliotecario = self.bibliotecario_model.get_by_cpf(cpf, self.conn)
            
            if bibliotecario is not None:
                return bibliotecario.id_bibliotecario
            
            assistente = self.assistente_model.get_by_cpf(cpf, self.conn)
        
            if assistente is not None:
                return assistente.id_assistente
            
            raise exceptions.AutorizacaoException("Funcionário não encontrado. CPF inválido.")
        
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao autenticar funcionário: {e}")
        
    def criar_usuario(self, **dicionario: Any) -> int:

        categoria = dicionario.get('categoria')
        if not categoria:
            raise exceptions.NegocioException("A 'categoria' do usuário é obrigatória.")
        
        try:
            novo_id = None

            if categoria == 'aluno_grad':
                aluno = AlunoGraduacao(
                    quantidade_limite_emprestimos = 5,
                    tempo_emprestimo = 15
                )
                
                aluno.nome = dicionario['nome']
                aluno.telefone = dicionario['telefone']
                aluno.endereco = dicionario['endereco']
                aluno.categoria = categoria

                novo_id = self.aluno_grad_model.create(aluno, self.conn)

            elif categoria == 'aluno_pos':
                aluno_pos = AlunoPosGraduacao(
                    quantidade_limite_emprestimos = 10,
                    tempo_emprestimo = 30
                )
                
                aluno_pos.nome = dicionario['nome']
                aluno_pos.telefone = dicionario['telefone']
                aluno_pos.endereco = dicionario['endereco']
                aluno_pos.categoria = categoria
                
                novo_id = self.aluno_pos_grad_model.create(aluno_pos, self.conn)

            elif categoria == 'professor':
                professor = Professor(
                    tipo_contrato = dicionario['tipo_contrato'],
                    quantidade_limite_emprestimos = 15,
                    tempo_emprestimo = 30
                )
                
                professor.nome = dicionario['nome']
                professor.telefone = dicionario['telefone']
                professor.endereco = dicionario['endereco']
                professor.categoria = categoria
                
                novo_id = self.professor_model.create(professor, self.conn)

            elif categoria == 'professor_pos':

                professor_pos = ProfessorPos(
                    tipo_contrato = dicionario['tipo_contrato'],
                    quantidade_limite_emprestimos = 20,
                    tempo_emprestimo = 90
                )
                
                professor_pos.nome = dicionario['nome']
                professor_pos.telefone = dicionario['telefone']
                professor_pos.endereco = dicionario['endereco']
                professor_pos.categoria = categoria

                novo_id = self.professor_pos_model.create(professor_pos, self.conn)
            
            else:
                raise exceptions.NegocioException(f"Categoria de usuário '{categoria}' desconhecida.")
            
            self.conn.commit()
            return novo_id
        
        except (psycopg2.Error, ValueError, KeyError) as e:
            self.conn.rollback()
            if isinstance(e, KeyError):
                raise exceptions.NegocioException(f"Erro ao criar usuário: Campo obrigatório faltando: {e}")
            raise exceptions.NegocioException(f"Erro ao criar usuário: {e}")

        
    def listar_todos_usuarios(self) -> Set[Usuario]:

        try:
            return self.usuario_model.list_all(self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar usuários: {e}")
        
    def buscar_usuario_por_id(self, id_usuario: int) -> Usuario:
        
        try:
            usuario = self.usuario_model.get_by_id(id_usuario, self.conn)
            if usuario is None:
                raise exceptions.RecursoNaoEncontradoException(f"Usuário com ID {id_usuario} não encontrado.")
            return usuario
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar usuário por ID: {e}")

    def buscar_usuario_por_nome(self, nome: str) -> Usuario:
        
        try:
            usuario = self.usuario_model.get_by_nome(nome, self.conn)
            if usuario is None:
                raise exceptions.RecursoNaoEncontradoException(f"Usuário com nome {nome} não encontrado.")
            return usuario
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar usuário por nome: {e}")
        
    def listar_usuarios_com_multas(self) -> Set[Usuario]:

        try:
            return self.emprestimo_model.get_usuarios_com_multas(self.conn)
        
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar usuários com multas: {e}")
        
    def buscar_usuarios_por_nome_parcial(self, nome: str) -> Set[Usuario]:
        try:
            usuarios = self.usuario_model.get_by_nome_parcial(nome, self.conn)
            if not usuarios:
                raise exceptions.RecursoNaoEncontradoException(f"Nenhum usuário encontrado com o nome: '{nome}'.")
            return usuarios
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar usuários por nome: {e}")
        
