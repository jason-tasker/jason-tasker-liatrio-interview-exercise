#!/bin/sh

echo "Change directory to app"
cd app

echo "Create python virtual env and load pip packages"
python -m venv venv
source venv/bin/activate

pip install --no-cache-dir -r requirements.txt

echo "Test application"
python -m pytest

echo "Run application on http://127.0.0.1:8080"

gunicorn -w 4 run:app -b 127.0.0.1:8080
