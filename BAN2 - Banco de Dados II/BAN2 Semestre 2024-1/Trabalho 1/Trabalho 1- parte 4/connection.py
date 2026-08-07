import psycopg2
from psycopg2.extensions import connection

DB_NAME = "biblioteca"
DB_USER = "postgres"
DB_PASS = "udesc"
DB_HOST = "localhost"
DB_PORT = "5432"

def get_database_connection() -> connection:
    
    try: 
        conn = psycopg2.connect(
            dbname = DB_NAME,
            user = DB_USER,
            password = DB_PASS,
            host = DB_HOST,
            port = DB_PORT
        )
        return conn
    except psycopg2.OperationalError as e:
        print(f"Erro: Não foi possível connectar ao banco de dados")
        print(e)
        exit()