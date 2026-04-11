from flask import Blueprint, jsonify
from controllers.tournamentController import get_all_tournaments, get_tournament_details

tournament_bp = Blueprint('tournament_bp', __name__)

@tournament_bp.route('/', methods=['GET'])
def fetch_tournaments():
    response, status_code = get_all_tournaments()
    return jsonify(response), status_code

@tournament_bp.route('/<int:tournament_id>', methods=['GET'])
def fetch_tournament_details(tournament_id):
    response, status_code = get_tournament_details(tournament_id)
    return jsonify(response), status_code