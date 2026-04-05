from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def get_players_ranking():
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            cursor.execute("""
            SELECT 
                DENSE_RANK() OVER(ORDER BY
                    COALESCE(ROUND(CAST(SUM(ED.kos) AS NUMERIC) / NULLIF(SUM(ED.restarts), 0), 2), 0) DESC
                ) AS posicion_ranking,
                JE.gamertag,
                JE.nombre_equipo,
                SUM(ED.kos) AS total_kos, 
                SUM(ED.restarts) AS total_restarts, 
                SUM(ED.assists) AS total_assists, 
                COALESCE(ROUND(CAST(SUM(ED.kos) AS NUMERIC) / NULLIF(SUM(ED.restarts), 0), 2), 0)::FLOAT AS kd_ratio
            FROM jugador_en_equipo JE
            JOIN estadisticas_jugador ED ON JE.gamertag = ED.gamertag
            GROUP BY JE.gamertag, JE.nombre_equipo
            HAVING COUNT(ED.id_partida) >= 2
            ORDER BY kd_ratio DESC;
            """)
            result = cursor.fetchall()

        return {"result": result}
    except Exception as e:
        return {"db_error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)

def get_team_evolution(name):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            if name != "none":
                cursor.execute("""
                SELECT 
                    CASE
                        WHEN P.fase = 'fase de grupos' THEN 'Fase de Grupos'
                        WHEN P.fase IN ('semifinal', 'final') THEN 'Eliminatorias'
                    END AS etapa,
                    ROUND(AVG(ED.kos), 2)::FLOAT AS kos_avg, 
                    ROUND(AVG(ED.restarts), 2)::FLOAT AS restarts_avg, 
                    ROUND(AVG(ED.assists), 2)::FLOAT AS assists_avg
                FROM jugador_en_equipo JE
                JOIN estadisticas_jugador ED ON JE.gamertag = ED.gamertag
                JOIN partidas P ON ED.id_partida = P.id_partida
                WHERE JE.nombre_equipo = %s
                GROUP BY etapa
                ORDER BY etapa DESC;
                """, (name,))
            else:
                cursor.execute("""
                SELECT 
                    nombre_equipo,
                    CASE
                        WHEN P.fase = 'fase de grupos' THEN 'Fase de Grupos'
                        WHEN P.fase IN ('semifinal', 'final') THEN 'Eliminatorias'
                    END AS etapa,
                    ROUND(AVG(ED.kos), 2)::FLOAT AS kos_avg, 
                    ROUND(AVG(ED.restarts), 2)::FLOAT AS restarts_avg, 
                    ROUND(AVG(ED.assists), 2)::FLOAT AS assists_avg
                FROM jugador_en_equipo JE
                JOIN estadisticas_jugador ED ON JE.gamertag = ED.gamertag
                JOIN partidas P ON ED.id_partida = P.id_partida
                GROUP BY (nombre_equipo, etapa)
                ORDER BY (nombre_equipo) DESC;
                """)

            result = cursor.fetchall()

        return {"team_name": name, "result": result}
    except Exception as e:
        return {"db_error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)