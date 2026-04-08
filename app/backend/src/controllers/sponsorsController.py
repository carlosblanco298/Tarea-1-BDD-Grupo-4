from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def get_sponsors_by_videogame(videogame):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            #SELECT Nombre, Industria, SUM(Monto_aporte) AS Total
            cursor.execute("""
            WITH torneos_actual AS (
                SELECT id_torneo FROM Torneos WHERE Videojuego = %s
            )

            SELECT nombre, industria, SUM(Monto_aporte) AS total_aportado
            FROM Sponsors, Sponsor_Torneo
            WHERE Sponsors.id_Sponsor = Sponsor_Torneo.id_Sponsor 
                AND Sponsor_Torneo.id_torneo IN 
                           (SELECT id_torneo FROM torneos_actual)
                AND Sponsor_Torneo.id_Sponsor NOT IN(
                SELECT DISTINCT id_sponsor
                FROM (
                SELECT id_sponsor, torneos_actual.id_torneo
                FROM Sponsor_Torneo, torneos_actual
                EXCEPT(
                SELECT id_sponsor, torneos_actual.id_torneo
                FROM Sponsor_Torneo, torneos_actual
                WHERE Sponsor_Torneo.ID_Torneo = torneos_actual.ID_Torneo)))
            GROUP BY Sponsors.id_sponsor;
            """, (videogame,))
            sponsors = cursor.fetchall()
            return {"status": "success", "data": sponsors}, 200
    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)