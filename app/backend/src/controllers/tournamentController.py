from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def get_all_tournaments():
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            # Listar todos los torneos con su información básica.
            cursor.execute("""
                SELECT id_torneo, nombre, videojuego, fecha_inicio, fecha_fin, prize_pool, max_equipos 
                FROM Torneos
                ORDER BY fecha_inicio DESC;
            """)
            tournaments = cursor.fetchall()
            return {"status": "success", "data": tournaments}, 200
    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)

def get_tournament_details(tournament_id):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            # Las partidas jugadas con sus resultados.

            cursor.execute("""
                SELECT nombre_equipo 
                FROM Inscripciones 
                WHERE id_torneo = %s;
            """, (tournament_id,))
            equipos = cursor.fetchall()

            cursor.execute("""
                SELECT s.nombre, s.industria, st.monto_aporte 
                FROM Sponsors s
                JOIN Sponsor_Torneo st ON s.id_sponsor = st.id_sponsor
                WHERE st.id_torneo = %s;
            """, (tournament_id,))
            sponsors = cursor.fetchall()

            cursor.execute("""
                SELECT equipo_a, equipo_b, score_a, score_b, fase, fecha_hora 
                FROM Partidas 
                WHERE id_torneo = %s 
                ORDER BY fecha_hora ASC;
            """, (tournament_id,))
            partidas = cursor.fetchall()

            cursor.execute("""
                WITH Stats AS (
                    SELECT 
                        equipo_a AS equipo,
                        1 AS jugada,
                        CASE WHEN score_a > score_b THEN 1 ELSE 0 END AS ganada,
                        CASE WHEN score_a = score_b THEN 1 ELSE 0 END AS empatada,
                        CASE WHEN score_a < score_b THEN 1 ELSE 0 END AS perdida,
                        CASE WHEN score_a > score_b THEN 3 WHEN score_a = score_b THEN 1 ELSE 0 END AS puntos
                    FROM Partidas
                    WHERE id_torneo = %s AND fase = 'fase de grupos'
                    
                    UNION ALL
                    
                    SELECT 
                        equipo_b AS equipo,
                        1 AS jugada,
                        CASE WHEN score_b > score_a THEN 1 ELSE 0 END AS ganada,
                        CASE WHEN score_b = score_a THEN 1 ELSE 0 END AS empatada,
                        CASE WHEN score_b < score_a THEN 1 ELSE 0 END AS perdida,
                        CASE WHEN score_b > score_a THEN 3 WHEN score_b = score_a THEN 1 ELSE 0 END AS puntos
                    FROM Partidas
                    WHERE id_torneo = %s AND fase = 'fase de grupos'
                )
                SELECT 
                    equipo,
                    SUM(jugada) AS partidas_jugadas,
                    SUM(ganada) AS ganadas,
                    SUM(empatada) AS empatadas,
                    SUM(perdida) AS perdidas,
                    SUM(puntos) AS puntaje_total
                FROM Stats
                GROUP BY equipo
                ORDER BY puntaje_total DESC, ganadas DESC;
            """, (tournament_id, tournament_id))
            tabla_posiciones = cursor.fetchall()

            detalles = {
                "equipos_inscritos": equipos,
                "sponsors": sponsors,
                "partidas": partidas,
                "tabla_posiciones": tabla_posiciones
            }
            
            return {"status": "success", "data": detalles}, 200

    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)