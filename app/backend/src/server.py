from flask import Flask, render_template
from dotenv import load_dotenv
from routes.sponsorsRoute import sponsor_bp

load_dotenv()

app = Flask(__name__, 
    template_folder='../../frontend/src/templates',
    static_folder='../../frontend/src/static'
)
app.register_blueprint(sponsor_bp, url_prefix='/api/sponsors')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/sponsors')
def sponsors():
    return render_template('sponsors.html')

if __name__ == "__main__":
    app.run(host="localhost", port=3000)