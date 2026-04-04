from flask import Flask
from dotenv import load_dotenv
from routes.enrollmentRoute import inscription_bp

load_dotenv()

app = Flask(__name__)

app.register_blueprint(inscription_bp, url_prefix='/api/team_enrollment')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)