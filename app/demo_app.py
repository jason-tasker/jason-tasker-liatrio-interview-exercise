""" demo_app.py - application instance """
# Liatrio Demo Python app to return JSON payload

from datetime import datetime, timezone
from flask import Flask, jsonify

# Main Flask application
def create_app(test_config=None):
    """ Setup Flask with JSON Pretty Print """
    app = Flask(__name__)
    app.json.compact = False # Ensure pretty printing

    if test_config is None:
        app.config.from_pyfile('config.py', silent=True)
    else:
        app.config.update(test_config)

    # Setup Rest API
    @app.route('/')
    def return_payload():
        """ Create and Return payload """
        # Get current UTC time
        current_datetime = datetime.now(timezone.utc)
        # Convert current UTC time to EPOCH float timestamp
        epoch_timestamp_float = current_datetime.timestamp()
        # Convert EPOCH fload timestamp to integer
        epoch_timestamp_int = int(epoch_timestamp_float)

        # Create JSON Payload
        payload = {
            'message': 'Automate all the things!',
            'timestamp': epoch_timestamp_int
        }
        # Return payload
        return jsonify(payload)

    return app
