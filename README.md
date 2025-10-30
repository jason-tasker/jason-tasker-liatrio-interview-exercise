# jason-tasker-liatrio-interview-exercise

## Problem Statement
A potential client, XYZ, is a traditional on-premises infrastructure shop that wants to move to the cloud. Developers report slow environment kickoffs, long dev cycles, and inconsistent environments. Management reports downtime during deployments, difficulty rolling back, and low code quality reaching production. Liatrio has been asked to show what good could look like. XYZ is interested in containerization and possibly
Kubernetes.

Build an application in the programming language of your choice that exposes a REST endpoint returning this JSON payload with the current timestamp and a static message:

```
{
    “message”: “Automate all the things!”,
    “timestamp”: 1529729125
}
```

Deploy the application to a Kubernetes cluster running in a public cloud provider of your choice. Provision the cluster and deploy the application using code.

Costs: This exercise can be completed for under 100 dollars. We will reimburse up to 100 dollars. Please monitor running services, keep an eye on costs, and shut things down when not needed. Ask in Slack if you have cost questions.

Be creative. There are many valid approaches. This is meant to approximate real work: ambiguity, unfamiliar tools, and multiple viable technical paths.

You can showcase depth with technologies you know or use this to learn something new while demonstrating problem solving.

## Requirements
* Address the problem statement in your solution.
* Commit all code to a public Git repository.● Include a README.md with clear instructions to deploy, run, and clean up.
* Provide a simple, reusable way to deploy both infrastructure and application.
* Prerequisites are fine if documented.
* We should be able to deploy and run the application in our own cloud accounts.
* Include automated tests that validate the environment and or application.
* Consider developer experience and make future contributions easy.
* Prepare a presentation in a format of your choice.
* Do a short demo prep call with a Liatrio engineer before the presentation

## Solution

### Application code
A python application has been built using Flask (Lightweight WSGI web application framework) and Gunicorn (Python WSGI HTTP Server). The application has a single REST API accessible from the main index. Pytest is also used to verify the application.

### Local Development
```bootstrap.sh``` is provided to launch the application locally to verify the application is functioning prior to containerization and deployment.  This script will create a new (or update) a python virtual environment in the ```app/venv``` directory.  PIP will then install the python packages needed into this directory.  The script will then launch pytest to verify the application passes testing before launching gunicorn on the localhost on port 8080.  The application will then be available on http://127.0.0.1:8080 (assuming no conflicts with other local services). Using curl in another terminal or a webbrowser can access this API. Terminate the API by stopping the script.

### Local Container Development
```bootstrap-docker.sh``` is provided to launch the application in a docker container locally.  The Dockerfile is used to build the container.  During the build, pytest will verify the application.  This script will then launch the container locally and be available at http://127.0.0.1:8080 (assuming no conflicts with other local services). Using curl in another terminal or a webbrowser can access this API. Terminate the API by stopping the container.

###
