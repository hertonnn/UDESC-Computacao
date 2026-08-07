import psycopg2
from psycopg2.extensions import connection
from dataclasses import dataclass
from typing import Optional, Set
from datetime import date


@dataclass(frozen=True, eq=True)
class Reserva:
    data_reserva: date
    situacao: str
    id_usuario: int
    id_exemplar: int
    id_reserva: Optional[int] = None

class ReservaModel:

    def create_reserva(self, reserva: Reserva, conn: connection) -> int:

        sql = """
            INSERT INTO Reserva (data_reserva, situacao, id_usuario, id_exemplar) 
            VALUES (%s, %s, %s, %s) 
            RETURNING id_reserva
        """
        params = (
            reserva.data_reserva,
            reserva.situacao,
            reserva.id_usuario,
            reserva.id_exemplar
        )
        
        with conn.cursor() as cursor:
            cursor.execute(sql, params)
            novo_id = cursor.fetchone()[0]
            
        return novo_id

    def get_reserva_by_id(self, id_reserva: int, conn: connection) -> Optional[Reserva]:

        sql = """
            SELECT id_reserva, data_reserva, situacao, id_usuario, id_exemplar 
            FROM Reserva 
            WHERE id_reserva = %s
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_reserva,))
            row = cursor.fetchone()
            
            if row:
                return Reserva(
                    id_reserva=row[0],
                    data_reserva=row[1],
                    situacao=row[2],
                    id_usuario=row[3],
                    id_exemplar=row[4]
                )
            else:
                return None

    def get_reservas_ativas_by_exemplar_id(self, id_exemplar: int, conn: connection) -> Set[Reserva]:

        lista_reservas: Set[Reserva] = set()
        sql = """
            SELECT id_reserva, data_reserva, situacao, id_usuario, id_exemplar 
            FROM Reserva 
            WHERE id_exemplar = %s AND situacao = 'ativa' 
            ORDER BY data_reserva ASC
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_exemplar,))
            for row in cursor:
                lista_reservas.add(Reserva(
                    id_reserva=row[0],
                    data_reserva=row[1],
                    situacao=row[2],
                    id_usuario=row[3],
                    id_exemplar=row[4]
                ))
                
        return lista_reservas

    def get_proxima_reserva_na_fila(self, id_exemplar: int, conn: connection) -> Optional[Reserva]:
 
        sql = """
            SELECT id_reserva, data_reserva, situacao, id_usuario, id_exemplar 
            FROM Reserva 
            WHERE id_exemplar = %s AND situacao = 'ativa' 
            ORDER BY data_reserva ASC 
            LIMIT 1
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_exemplar,))
            row = cursor.fetchone()
            
            if row:
                return Reserva(
                    id_reserva=row[0],
                    data_reserva=row[1],
                    situacao=row[2],
                    id_usuario=row[3],
                    id_exemplar=row[4]
                )
            else:
                return None

    def get_reservas_ativas_by_usuario_id(self, id_usuario: int, conn: connection) -> Set[Reserva]:

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

    def update_situacao_reserva(self, id_reserva: int, nova_situacao: str, conn: connection) -> None:

        sql = "UPDATE Reserva SET situacao = %s WHERE id_reserva = %s"
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (nova_situacao, id_reserva))

    def remove_reserva(self, id_reserva: int, conn: connection) -> None:

        sql = "DELETE FROM Reserva WHERE id_reserva = %s"
        
        with conn.cursor() as cursor:
            cursor.execute(sql, (id_reserva,))

    def list_ativas_com_nomes(self, conn: connection) -> Set[tuple]:
        
        lista_reservas: Set[tuple] = set()
        sql = """
            SELECT 
                r.id_reserva, 
                r.data_reserva, 
                u.nome, 
                l.titulo 
            FROM Reserva r 
            JOIN Usuario u ON r.id_usuario = u.id_usuario 
            JOIN Exemplar ex ON r.id_exemplar = ex.id_exemplar 
            JOIN Livro l ON ex.id_livro = l.id_livro 
            WHERE r.situacao = 'ativa' 
            ORDER BY r.data_reserva ASC
        """
        
        with conn.cursor() as cursor:
            cursor.execute(sql)
            for row in cursor:
                lista_reservas.add((
                    row[0], 
                    row[1], 
                    row[2], 
                    row[3]  
                ))
        return lista_reservas