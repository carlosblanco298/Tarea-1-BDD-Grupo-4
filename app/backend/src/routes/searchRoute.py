from flask import Blueprint, jsonify, request
from controllers.searchController import search_players, search_teams

search_bp = Blueprint('search_bp', __name__)

@search_bp.route('/players', methods=['GET'])
def find_players():
    query = request.args.get('q', '')
    response, status = search_players(query)
    return jsonify(response), status

@search_bp.route('/teams', methods=['GET'])
def find_teams():
    query = request.args.get('q', '')
    response, status = search_teams(query)
    return jsonify(response), status