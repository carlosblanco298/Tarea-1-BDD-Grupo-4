from flask import Flask
from dotenv import load_dotenv
from routes.sponsorsRoute import sponsor_bp

load_dotenv()

app = Flask(__name__)
app.register_blueprint(sponsor_bp, url_prefix='/api/sponsors')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)