# Load python v3.13.9 with alpine linux
FROM python:3.13.9-alpine
# Configure container
WORKDIR /app
COPY app/ .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
# Run pytest
RUN python -m pytest
# Launch gunicorn (Python WSGI HTTP Server)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8080", "run:app"]
