from flask import Flask
from dotenv import load_dotenv
from routes.tournamentRoute import tournament_bp

load_dotenv()

app = Flask(__name__)

app.register_blueprint(tournament_bp, url_prefix='/api/tournaments')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)