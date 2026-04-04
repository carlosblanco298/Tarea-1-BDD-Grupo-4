from flask import Flask
from dotenv import load_dotenv
from routes.statsRoute import stats_bp

load_dotenv()

app = Flask(__name__)

app.register_blueprint(stats_bp, url_prefix='/api/stats')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)