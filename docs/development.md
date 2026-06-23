# Development Guide

How to run this project locally. This document will be filled in further as
backend and frontend code is actually built - the steps below reflect the
intended setup per the architecture, and should be corrected if reality
differs once implementation begins.

---

## Prerequisites

- Python 3.12+
- Node.js (LTS version) and npm
- A PostgreSQL database with the pgvector extension enabled (a free Supabase
  project is the recommended path - see docs/deployment.md)
- An OpenAI API key with a small amount of credit loaded

---

## First-Time Setup

1. Clone the repository.
2. Copy the environment variable template and fill in your own values:
   cp .env.example .env
   See .env.example for the full list of required variables.
3. Set up the backend (see below).
4. Set up the frontend (see below).

---

## Backend Setup

cd backend
python -m venv venv

Activate the virtual environment:
source venv/bin/activate        # macOS/Linux
venv\Scripts\activate           # Windows PowerShell/CMD

pip install -r requirements.txt
uvicorn app.main:app --reload

The backend will be available at http://localhost:8000. FastAPI provides
automatic interactive API docs at http://localhost:8000/docs once the app
is running - useful for testing endpoints directly without the frontend.

Note: requirements.txt does not exist yet as of this writing - it will be
added when backend scaffolding is implemented.

---

## Frontend Setup

cd frontend
npm install
npm run dev

The frontend dev server will be available at http://localhost:5173 (Vite's
default port) and is configured to call the backend at the URL specified by
FRONTEND_URL/backend .env config.

Note: package.json does not exist yet as of this writing - it will be
added when frontend scaffolding is implemented.

---

## Running Tests

cd backend
pytest

Per DECISIONS.md D004, test coverage is intentionally scoped to the chunking
and retrieval logic plus one integration test - not comprehensive coverage.
See backend/tests/ once implemented.

---

## Adding a New Source Document

To add a new document to the knowledge base:

1. Add a new markdown file to backend/data/source_documents/.
2. Re-run the ingestion process (exact command to be documented once the
   ingestion endpoint/script is implemented).

---

## Common Local Issues

**PowerShell blocks venv\Scripts\activate with an execution policy error.**
Run this once: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
This allows locally created scripts to run while still requiring downloaded
scripts to be signed - the standard safe setting for local development.

**CORS errors when the frontend calls the backend.**
Confirm FRONTEND_URL in your .env matches the actual URL the frontend dev
server is running on (default http://localhost:5173).

---

## Status of This Document

This is a living document. Sections marked with a note that something
"does not exist yet" should be revisited and completed as each phase of
implementation lands.