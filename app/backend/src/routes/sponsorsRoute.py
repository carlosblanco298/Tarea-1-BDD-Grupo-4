from flask import Blueprint, jsonify
from controllers.sponsorsController import get_sponsors_by_videogame

sponsor_bp = Blueprint('sponsor_bp', __name__)

@sponsor_bp.route('/<string:videogame>', methods=['GET'])
def fetch_sponsors_by_videogame(videogame):
    response, status_code = get_sponsors_by_videogame(videogame)
    return jsonify(response), status_code