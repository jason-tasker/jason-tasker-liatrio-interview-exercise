""" run.py - main application file """
from demo_app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)
