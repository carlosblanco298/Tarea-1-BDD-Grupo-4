import os
from psycopg2 import pool
from dotenv import load_dotenv

load_dotenv()

connection_pool = pool.ThreadedConnectionPool(
    1, 20,
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD")
)

def get_db():
    return connection_pool.getconn()

def release_db(conn):
    connection_pool.putconn(conn)