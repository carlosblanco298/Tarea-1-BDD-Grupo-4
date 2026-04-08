from psycopg2.extras import RealDictCursor
from config.db import get_db, release_db

def tournament_enrollment(team_name, tournament_name):
    conn = None
    try:
        conn = get_db()
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:

            # Revisamos si el torneo existe
            cursor.execute("""
            SELECT id_torneo FROM Torneos WHERE nombre = %s;
            """, (tournament_name,))

            tournament_id = cursor.fetchone()

            if not tournament_id:
                raise Exception(f'Couldnt find tournament with name {tournament_name}. Maybe you misspelled it. Try again.')
            else:
                tournament_id = tournament_id['id_torneo']

            # En caso que exista el torneo con el nombre indicado continuamos

            # Revisamos si el equipo ya está inscrito en el torneo
            cursor.execute("""
                SELECT 1 FROM Inscripciones
                WHERE id_torneo = %s AND nombre_equipo = %s;
            """, (tournament_id, team_name))
            enrollment = cursor.fetchone()

            if enrollment:
                return {"status": "conflict", "message": "Team is already enrolled in this tournament"}, 409
            
            # En caso de no estar inscrito. Lo inscribimos

            cursor.execute("""
            INSERT INTO Inscripciones (id_torneo, nombre_equipo)
            SELECT %(torneo_id)s, %(nombre_equipo)s
            FROM Torneos T
            WHERE (
                T.id_torneo = %(torneo_id)s
                AND (SELECT COUNT(*) FROM Inscripciones WHERE id_torneo = %(torneo_id)s) < 8
                AND EXISTS (SELECT 1 FROM Equipos WHERE nombre_equipo LIKE %(nombre_equipo)s)
                AND NOT EXISTS (SELECT 1 FROM Inscripciones WHERE id_torneo = %(torneo_id)s AND nombre_equipo LIKE %(nombre_equipo)s)
            )
            RETURNING *;
            """, {"nombre_equipo": team_name, "torneo_id": tournament_id})
            new_row = cursor.fetchone()
            print(new_row)
            if new_row:
                conn.commit()
                return {"status": "success", "data": new_row}, 201
            else:
                return {"status": "failed", "message": "Tournament full or team missing"}, 404

    except Exception as e:
        if conn:
            conn.rollback()
        return {"error": str(e)}, 500
    finally:
        if conn is not None:
            release_db(conn)