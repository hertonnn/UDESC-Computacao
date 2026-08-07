import psycopg2
from typing import Set, Optional

from model.editora_model import Editora, EditoraModel

class EditoraService:
    def __init__(self, db_connection):
        self.db_conn = db_connection
        self.editora_model = EditoraModel()

    def listar_editoras(self) -> Set[Editora]:
        try:
            return self.editora_model.list_all(self.db_conn)
        except Exception as e:
            raise Exception(f"Erro ao listar editoras: {str(e)}")

    def adicionar_editora(self, nome: str) -> int:
        try:
            if not nome or nome.strip() == "":
                raise ValueError("Nome da editora não pode estar vazio")
                
            editora = Editora(nome=nome, id_editora=None)
            return self.editora_model.create(editora, self.db_conn)
        except Exception as e:
            raise Exception(f"Erro ao adicionar editora: {str(e)}")

    def remover_editora(self, id_editora: int) -> None:
        try:
            self.editora_model.remove(id_editora, self.db_conn)
        except Exception as e:
            raise Exception(f"Erro ao remover editora: {str(e)}")

    def buscar_editora(self, id_editora: int) -> Optional[Editora]:
        try:
            return self.editora_model.get_by_id(id_editora, self.db_conn)
        except Exception as e:
            raise Exception(f"Erro ao buscar editora: {str(e)}")