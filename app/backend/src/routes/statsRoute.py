from flask import Blueprint, request
from controllers.statsController import get_players_ranking, get_team_evolution

stats_bp = Blueprint('stats', __name__)

@stats_bp.route("/player_rankings", methods=["GET"])
def player_ranking():
    tournament_name = request.args.get("tournament_name", "none")
    return get_players_ranking(tournament_name)

@stats_bp.route("/team_evolutions", methods=["GET"])
def team_evolv():
    team_name = request.args.get("team_name", "none")
    tournament_name = request.args.get("tournament_name", "none")
    return get_team_evolution(team_name, tournament_name)
