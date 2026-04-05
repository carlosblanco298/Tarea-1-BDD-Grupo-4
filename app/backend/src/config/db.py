
from psycopg2 import pool
from dotenv import load_dotenv

try:
conn = psycopg2.connect(
database=“database”,
user=“user”,
host=“localhost”,
port=5432,
password=“pass”)
except:
print(“No me pude conectar”)