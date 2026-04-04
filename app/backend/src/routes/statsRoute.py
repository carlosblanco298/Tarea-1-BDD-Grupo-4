from flask import Blueprint, request
from controllers.statsController import get_players_ranking, get_team_evolution

stats_bp = Blueprint('stats', __name__)

@stats_bp.route("/player_rankings", methods=["GET"])
def player_ranking():
    return get_players_ranking()

@stats_bp.route("/team_evolutions", methods=["GET"])
def team_evolv():
    name = request.args.get("team_name", "none")
    return get_team_evolution(name)
