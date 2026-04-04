from flask import Blueprint, request
from controllers.enrollmentController import tournament_enrollment

inscription_bp = Blueprint('inscription', __name__)

@inscription_bp.route('', methods=["POST"])
def enroll_team():
    try:
        team_name = request.args.get('team_name')
        tournament_name = request.args.get('tournament_name')
        if not team_name or not tournament_name:
            raise ValueError("All fields are required and cannot be empty")

        return tournament_enrollment(team_name, tournament_name)
        
    except ValueError as e:
        return {"db_error": str(e)}, 400
