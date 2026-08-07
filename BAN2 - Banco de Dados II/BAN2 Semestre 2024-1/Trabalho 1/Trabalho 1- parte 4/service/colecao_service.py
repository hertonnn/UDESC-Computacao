from typing import Set

from model.colecao_model import Colecao, ColecaoModel
from psycopg2.extensions import connection


class ColecaoService:
    def __init__(self, conn: connection):
        self.conn = conn
        self.model = ColecaoModel()

    def adicionar_colecao(self, nome: str) -> int:
        """
        Adiciona uma nova coleção ao sistema.
        
        Args:
            nome: Nome da coleção
            
        Returns:
            id da coleção criada
        """
        colecao = Colecao(nome=nome)
        return self.model.create(colecao, self.conn)

    def remover_colecao(self, id_colecao: int) -> None:
        """
        Remove uma coleção do sistema.
        
        Args:
            id_colecao: ID da coleção a ser removida
        """
        self.model.remove(id_colecao, self.conn)

    def listar_colecoes(self) -> Set[Colecao]:
        """
        Lista todas as coleções cadastradas no sistema.
        
        Returns:
            Conjunto de objetos Colecao
        """
        return self.model.list_all(self.conn)