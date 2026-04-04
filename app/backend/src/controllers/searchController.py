from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def search_players(query):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            # Buscar jugadores por gamertag o país.
            cursor.execute("""
                SELECT gamertag, nombre_real, pais, nombre_equipo
                FROM jugadores
                WHERE gamertag ILIKE %s OR pais ILIKE %s;
            """, (f'%{query}%', f'%{query}%'))
            players = cursor.fetchall()
            return {"status": "success", "data": players}, 200
    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)
            
def search_teams(query):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            # Buscamos equipos por nombre.
            cursor.execute("""
                SELECT nombre_equipo, fecha_creacion, id_capitan
                FROM equipos
                WHERE nombre_equipo ILIKE %s;
            """, (f'%{query}%',))
            teams = cursor.fetchall()
            return {"status": "success", "data": teams}, 200
    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)