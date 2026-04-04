from flask import Flask
from dotenv import load_dotenv

from routes.searchRoute import search_bp

load_dotenv()

app = Flask(__name__)

app.register_blueprint(search_bp, url_prefix='/api/search')

if __name__ == '__main__':
    app.run(host='localhost', port=3000)