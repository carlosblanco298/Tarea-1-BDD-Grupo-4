import os
from flask import Flask, render_template
from dotenv import load_dotenv
from routes.statsRoute import stats_bp
from routes.sponsorsRoute import sponsor_bp
from routes.enrollmentRoute import inscription_bp
from routes.searchRoute import search_bp
from routes.tournamentRoute import tournament_bp

base_dir = os.path.dirname(os.path.abspath(__file__))
template_dir = os.path.join(base_dir, '..', '..', 'frontend', 'src', 'templates')
static_dir = os.path.join(base_dir, '..', '..', 'frontend', 'src', 'static')

app = Flask(__name__, 
    template_folder=template_dir,
    static_folder=static_dir
)
app = Flask(__name__)

app.register_blueprint(stats_bp, url_prefix='/api/stats')
app.register_blueprint(sponsor_bp, url_prefix='/api/sponsors')
app.register_blueprint(tournament_bp, url_prefix='/api/tournaments')
app.register_blueprint(search_bp, url_prefix='/api/search')
app.register_blueprint(inscription_bp, url_prefix='/api/team_enrollment')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/sponsors')
def sponsors():
    return render_template('sponsors.html')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)