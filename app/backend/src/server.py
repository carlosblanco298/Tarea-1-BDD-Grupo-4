import os
from flask import Flask, render_template
from dotenv import load_dotenv
from routes.sponsorsRoute import sponsor_bp

base_dir = os.path.dirname(os.path.abspath(__file__)) # This is /backend/src
template_dir = os.path.join(base_dir, '..', '..', 'frontend', 'src', 'templates')
static_dir = os.path.join(base_dir, '..', '..', 'frontend', 'src', 'static')

app = Flask(__name__, 
    template_folder=template_dir,
    static_folder=static_dir
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