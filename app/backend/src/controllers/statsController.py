from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def get_players_ranking():
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            cursor.execute("""
            SELECT RANK() OVER(ORDER BY kd_ratio DESC) AS posicion_ranking,
                T.gamertag,
                JE.nombre_equipo,
                T.total_kos,
                T.total_restarts,
                T.total_assists,
                T.kd_ratio
            FROM (
                SELECT gamertag,
                SUM(kos) AS total_kos,
                SUM(restarts) AS total_restarts,
                SUM(assists) AS total_assists,
                COUNT(id_partida) AS partidas,
                COALESCE(ROUND(CAST(SUM(kos) AS NUMERIC) / NULLIF(SUM(restarts), 0), 2), 0) AS kd_ratio
                FROM Estadisticas_Jugador
                GROUP BY gamertag
                HAVING COUNT(id_partida) >= 2
            ) as T
            JOIN (
                SELECT gamertag, nombre_equipo FROM Jugadores
            ) as JE ON JE.gamertag = T.gamertag
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
                SELECT *,
                    COALESCE(ROUND(CAST(kda - LAG(kda) OVER(PARTITION BY gamertag ORDER BY etapa ASC) AS NUMERIC), 2), 0)::FLOAT AS crecimiento_kda
                FROM (
                    SELECT
                        ED.gamertag,
                        CASE
                            WHEN P.fase = 'fase de grupos' THEN '1. Fase de Grupos'
                            WHEN P.fase IN ('semifinal', 'final') THEN '2. Eliminatorias'
                        END AS etapa,
                        ROUND(AVG(ED.KOS), 2)::FLOAT AS kos_avg,
                        ROUND(AVG(ED.restarts), 2)::FLOAT AS restarts_avg,
                        ROUND(AVG(ED.assists), 2)::FLOAT AS assists_avg,
                        ROUND(CAST(SUM(ED.kos) + SUM(ED.assists) AS NUMERIC) / NULLIF(SUM(ED.restarts), 0), 2)::FLOAT AS kda
                    FROM Estadisticas_Jugador ED
                    JOIN Partidas P ON P.id_partida = ED.id_partida
                    JOIN Jugadores AS J ON J.gamertag = ED.gamertag
                    WHERE J.nombre_equipo = %s
                    GROUP BY ED.gamertag, etapa
                ) as sub
                ORDER BY gamertag, etapa;
                """, (name,))

                result = cursor.fetchall()

            else:
                result = "Por favor. Ingrese el nombre del equipo que desea revisar."

        return {"team_name": name, "result": result}
    except Exception as e:
        return {"db_error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)