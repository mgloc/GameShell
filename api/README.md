# GameShell API

Custom API for progress tracking purposes

## Installation

### Pre-requisites

- Copy `.env.example` to `.env` and fill in the required environment variables

### Dev DB

```bash
# Start the DB
$ docker-compose up -d
```

### Python Server

```bash
# VirtualEnv (optional but recommended)
$ python3 -m venv .venv && source .venv/bin/activate

# Install dependencies
$ pip install -r requirements.txt

# Run the server
$ python3 asgi.py
```

API should run on `localhost:8080` by default

## Docs

Check `localhost:8080/docs` for the API documentation
