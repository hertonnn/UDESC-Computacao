import psycopg2
from psycopg2 import errors as psycopg2_errors
from psycopg2.extensions import connection
from typing import Optional, List, Set

import exceptions 

from model.autor_model import Autor, AutorModel
from model.editora_model import Editora, EditoraModel
from model.colecao_model import Colecao, ColecaoModel
from model.livro_model import Livro, LivroModel
from model.exemplar_model import Exemplar, ExemplarView, ExemplarModel

class AcervoService:

    def __init__(self, conn: connection):
        self.conn = conn
        self.autor_model = AutorModel()
        self.editora_model = EditoraModel()
        self.colecao_model = ColecaoModel()
        self.livro_model = LivroModel()
        self.exemplar_model = ExemplarModel()

    # --------------------- Funções (Autor) ---------------------

    def criar_autor(self, nome: str) -> int:

        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome do autor não pode estar em branco.")
        
        try:
            autor_objeto = Autor(nome = nome)
            novo_id = self.autor_model.create(autor_objeto, self.conn)
            self.conn.commit()
            return novo_id
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O autor '{nome}' já está cadastrado.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao criar autor: {e}")
        
    def editar_autor(self, id_autor: int, nome: str) -> None:

        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome do autor não pode estar em branco.")
        
        try:
            autor_obj = Autor(nome = nome, id_autor = id_autor)
            self.autor_model.update(autor_obj, self.conn)
            self.conn.commit()
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O nome '{nome}' já pertence a outro autor.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao editar autor: {e}")

    def remover_autor(self, id_autor: int) -> None:

        try:
            self.autor_model.remove(id_autor, self.conn)
            self.conn.commit()
        except psycopg2_errors.ForeignKeyViolation:
            self.conn.rollback()
            raise exceptions.NegocioException('Não é possível remover um autor que já está associado a livros.')
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao remover um autor: {e}")

    def listar_autores(self) -> Set[Autor]:
        
        try: 
            return self.autor_model.list_all(self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar autores: {e}")

    # --------------------- Funções (Editora) ---------------------

    def criar_editora(self, nome: str) -> int:

        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome da editora não pode estar em branco.")
            
        try:
            editora_obj = Editora(nome = nome)
            novo_id = self.editora_model.create(editora_obj, self.conn)
            self.conn.commit()
            return novo_id
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"A editora '{nome}' já está cadastrada.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao criar editora: {e}")
        
    def editar_editora(self, id_editora: int, nome: str) -> None:
        
        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome da editora não pode estar em branco.")
            
        try:
            editora_obj = Editora(nome=nome, id_editora=id_editora)
            self.editora_model.update(editora_obj, self.conn)
            self.conn.commit()
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O nome '{nome}' já pertence a outra editora.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao editar editora: {e}")
        
    def remover_editora(self, id_editora: int) -> None:

        try:
            self.editora_model.remove(id_editora, self.conn)
            self.conn.commit()
        except psycopg2_errors.ForeignKeyViolation:
            self.conn.rollback()
            raise exceptions.NegocioException("Não é possível remover uma editora que já está associada a livros.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao remover editora: {e}")
        
    def listar_editoras(self) -> Set[Editora]:
        try:
            return self.editora_model.list_all(self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar editoras: {e}")
        
    # --------------------- Funções (Coleção) ---------------------

    def criar_colecao(self, nome: str) -> int:

        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome da coleção não pode estar em branco.")
            
        try:
            colecao_obj = Colecao(nome = nome)
            novo_id = self.colecao_model.create(colecao_obj, self.conn)
            self.conn.commit()
            return novo_id
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"A coleção '{nome}' já está cadastrada.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao criar coleção: {e}")
        
    def editar_colecao(self, id_colecao: int, nome: str) -> None:
        
        if not nome or len(nome.strip()) == 0:
            raise exceptions.NegocioException("O nome da coleção não pode estar em branco.")
            
        try:
            colecao_obj = Colecao(nome=nome, id_colecao=id_colecao)
            self.colecao_model.update(colecao_obj, self.conn)
            self.conn.commit()
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O nome '{nome}' já pertence a outra coleção.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao editar coleção: {e}")

    def remover_colecao(self, id_colecao: int) -> None:

        try:
            self.colecao_model.remove(id_colecao, self.conn)
            self.conn.commit()
        except psycopg2_errors.ForeignKeyViolation:
            self.conn.rollback()
            raise exceptions.NegocioException("Não é possível remover uma coleção que já está associada a livros.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao remover coleção: {e}")

    def listar_colecoes(self) -> Set[Colecao]:

        try:
            return self.colecao_model.list_all(self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar coleções: {e}")
    
    # --------------------- Funções (Livro) ---------------------

    def criar_livro(self, titulo: str, isbn: Optional[str], id_colecao: Optional[int], 
                    lista_ids_autores: List[int], lista_ids_editoras: List[int]) -> int:

        if not titulo:
            raise exceptions.NegocioException("O título do livro é obrigatório.")
        if not lista_ids_autores:
            raise exceptions.NegocioException("O livro precisa de pelo menos um autor.")
        if not lista_ids_editoras:
            raise exceptions.NegocioException("O livro precisa de pelo menos uma editora.")

        try:
            livro_obj = Livro(titulo=titulo, isbn=isbn, id_colecao=id_colecao)
            id_livro = self.livro_model.create(livro_obj, self.conn)
            
            for id_autor in lista_ids_autores:
                self.livro_model.add_autor_to_livro(id_livro, id_autor, self.conn)
                
            for id_editora in lista_ids_editoras:
                self.livro_model.add_editora_to_livro(id_livro, id_editora, self.conn)
            
            self.conn.commit() 
            return id_livro

        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O ISBN '{isbn}' já está cadastrado em outro livro.")
        
        except psycopg2_errors.ForeignKeyViolation:
             self.conn.rollback()
             raise exceptions.RecursoNaoEncontradoException("Uma das Coleções, Autores ou Editoras fornecidas não existe.")

        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao criar livro: {e}")
    
    def editar_livro(self, id_livro: int, titulo: str, isbn: Optional[str], id_colecao: Optional[int], 
                     lista_ids_autores: List[int], lista_ids_editoras: List[int]) -> None:

        if not titulo:
            raise exceptions.NegocioException("O título do livro é obrigatório.")
        
        try:

            livro_obj = Livro(titulo=titulo, isbn=isbn, id_colecao=id_colecao, id_livro=id_livro)
            self.livro_model.update_livro(livro_obj, self.conn)

            autores_atuais = self.livro_model.get_autores_of_livro(id_livro, self.conn)
            ids_atuais = {a.id_autor for a in autores_atuais}
            ids_novos = set(lista_ids_autores)
            
            for id_autor in (ids_atuais - ids_novos):
                self.livro_model.remove_autor_from_livro(id_livro, id_autor, self.conn)
            for id_autor in (ids_novos - ids_atuais): 
                self.livro_model.add_autor_to_livro(id_livro, id_autor, self.conn)

            editoras_atuais = self.livro_model.get_editoras_of_livro(id_livro, self.conn)
            ids_atuais = {e.id_editora for e in editoras_atuais}
            ids_novos = set(lista_ids_editoras)

            for id_editora in (ids_atuais - ids_novos): 
                self.livro_model.remove_editora_from_livro(id_livro, id_editora, self.conn)
            for id_editora in (ids_novos - ids_atuais):
                self.livro_model.add_editora_to_livro(id_livro, id_editora, self.conn)

            self.conn.commit()

        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O ISBN '{isbn}' já está cadastrado em outro livro.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao editar livro: {e}")
    
    def remover_livro(self, id_livro: int) -> None:

        try: 
            self.livro_model.remove_livro(id_livro, self.conn)
            self.conn.commit()
        except psycopg2_errors.ForeignKeyViolation:
            self.conn.rollback()
            raise exceptions.NegocioException("Não é possível remover um livro que possui exemplares com empréstimos ativos.")
        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao remover livro: {e}")
        
    # --------------------- Funções (Exemplar) ---------------------

    def adicionar_exemplar(self, id_livro: int, numero_exemplar: int, is_colecao_reservada: bool) -> int:

        try:
            situacao = 'disponível'

            novo_id = self.exemplar_model.create_exemplar(
                id_livro = id_livro,
                numero_exemplar = numero_exemplar,
                conn = self.conn,
                situacao_inicial = situacao,
                is_colecao_reservada = is_colecao_reservada
            )

            self.conn.commit()
            return novo_id
        
        except psycopg2_errors.UniqueViolation:
            self.conn.rollback()
            raise exceptions.NegocioException(f"O exemplar número '{numero_exemplar}' para este livro já existe.")
        
        except psycopg2_errors.ForeignKeyViolation:
             self.conn.rollback()
             raise exceptions.RecursoNaoEncontradoException(f"O livro com ID {id_livro} não foi encontrado.")

        except psycopg2.Error as e:
            self.conn.rollback()
            raise exceptions.NegocioException(f"Erro inesperado ao adicionar exemplar: {e}")
        
    # --------------------- Funções (Listagem e busca) ---------------------

    def listar_livros(self) -> Set[Livro]:

        try:
            return self.livro_model.list_all_livros(self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar livros: {e}")
        
    def buscar_livro_por_id(self, id_livro: int) -> Optional[Livro]:

        try:
            return self.livro_model.get_by_id(id_livro, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar livro por ID: {e}")
    
    def buscar_livro_por_titulo(self, titulo: str) -> Set[Livro]:

        try:
            return self.livro_model.search_livro_by_titulo(titulo, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar livro por título: {e}")
        
    def buscar_livro_por_isbn(self, isbn: str) -> Optional[Livro]:

        try:
            return self.livro_model.search_livro_by_isbn(isbn, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar livro por ISBN: {e}")
        
    def buscar_exemplar_por_id(self, id_exemplar: int) -> Optional[ExemplarView]:

        try:
            return self.exemplar_model.get_exemplar_by_id(id_exemplar, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao buscar exemplar por ID: {e}")

    def listar_exemplares_de_livro(self, id_livro: int) -> Set[Exemplar]:

        try:
            return self.exemplar_model.list_exemplares_of_livro(id_livro, self.conn)
        except psycopg2.Error as e:
            raise exceptions.NegocioException(f"Erro ao listar exemplares: {e}")