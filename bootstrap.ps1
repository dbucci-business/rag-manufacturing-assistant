# bootstrap.ps1
# Development bootstrap script for the Manufacturing Knowledge Assistant repo.
#
# Run this from inside the repository root (rag-manufacturing-assistant/).
# Safe to run multiple times: existing files and folders are never
# overwritten or deleted. It only creates what's missing.

Write-Host "Bootstrapping project structure..." -ForegroundColor Cyan

# -----------------------------
# Folder structure
# -----------------------------
$folders = @(
    "docs",
    "backend/app/routes",
    "backend/app/services",
    "backend/app/db",
    "backend/app/schemas",
    "backend/tests",
    "backend/data/source_documents",
    "frontend/src/components",
    "frontend/src/services",
    ".github/workflows"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
}
Write-Host "Folder structure ready." -ForegroundColor Green

# -----------------------------
# Helper: create a file only if it doesn't already exist
# -----------------------------
function New-FileIfMissing {
    param(
        [string]$Path,
        [string]$Content = ""
    )

    if (Test-Path $Path) {
        Write-Host "Skipped (already exists): $Path" -ForegroundColor Yellow
    }
    else {
        Set-Content -Path $Path -Value $Content -NoNewline
        Write-Host "Created: $Path" -ForegroundColor Green
    }
}

# -----------------------------
# .gitkeep placeholders (so empty folders survive git)
# -----------------------------
$gitkeepFolders = @(
    "backend/app/routes",
    "backend/app/services",
    "backend/app/db",
    "backend/app/schemas",
    "backend/tests",
    "backend/data/source_documents",
    "frontend/src/components",
    "frontend/src/services"
)

foreach ($folder in $gitkeepFolders) {
    New-FileIfMissing -Path "$folder/.gitkeep"
}

# -----------------------------
# Root-level documentation and config files
# -----------------------------

New-FileIfMissing -Path "PROJECT_CHARTER.md" -Content @'
# Project Charter: Manufacturing Knowledge Assistant

## Purpose
A Retrieval-Augmented Generation (RAG) application that answers natural language
questions about manufacturing operations — SOPs, troubleshooting guides, safety
protocols, and KPI definitions — using a synthetic document corpus that simulates
an internal enterprise knowledge base.

## Why This Project Exists
Built as a portfolio project to demonstrate practical AI engineering competency
(RAG architecture, embeddings, vector search, LLM integration, full-stack
deployment) ahead of a referral-based interview for an AI Application Developer
role. The project intentionally simulates a real manufacturing use case based on
the developer's prior data analyst experience in that domain.

## Goals (in priority order)
1. Demonstrate a working, end-to-end RAG pipeline a hiring manager can use live
2. Be fully explainable by the developer in a technical interview — every
   architectural decision must be one the developer understands and can defend
3. Be deployed and publicly accessible, not just runnable locally
4. Demonstrate professional software practices (documentation, structure, testing)
5. Serve as a foundation the developer can extend after the interview if desired

## Non-Goals
- This is not a production system handling real manufacturing data
- This is not an attempt to build the most sophisticated RAG architecture possible
- This is not a multi-tenant or authenticated system
- This is not optimized for scale beyond demo-level usage

## Target Audience
- Primary: AI hiring manager reviewing the GitHub repository and/or live demo
- Secondary: The developer themselves, six months from now, needing to recall
  why decisions were made
- Tertiary: Any future AI assistant session helping extend or debug the project

## Success Criteria
- [ ] Deployed and reachable via a public URL
- [ ] Can ingest the synthetic document set and answer questions grounded in it
- [ ] Developer can verbally walk through the entire pipeline without notes
- [ ] Repository is clean enough that a stranger could understand it in 10 minutes
- [ ] README includes a working demo link, architecture diagram, and setup steps

## Constraints
- Single developer, AI-assisted development
- Approximately 2 weeks build time, 3 weeks absolute maximum
- Developer has a strong SQL/data analytics background, limited prior AI
  engineering experience
- Must remain understandable to the developer — no black-box components

## Out of Scope (see docs/future_enhancements.md for details)
- Authentication / user accounts
- Multi-LLM provider support (architecture allows it, not implemented in v1)
- Conversation history / multi-turn chat memory
- Admin dashboard for document management

## How to Use This Document
This file is the entry point for understanding *why* this project exists and
*what it is trying to achieve*. It should be read first — before any code,
before DECISIONS.md, before the architecture docs — by anyone (human or AI
assistant) picking up this project for the first time. If a proposed change
conflicts with the goals or non-goals stated here, that conflict should be
resolved before the change is made, not after.
'@

New-FileIfMissing -Path "DECISIONS.md" -Content @'
# Architectural Decisions Log

This file is the project's memory. Each entry records what was decided, why,
what alternatives were considered and rejected, and when. The goal is that any
future engineer or AI-assisted session can read this file and understand *why*
the system looks the way it does — without needing access to the original
conversations where these decisions were made.

**Format:** Decision -> Reasoning -> Alternatives Considered -> Date

---

## D001 - Vector Storage: PostgreSQL + pgvector

**Decision:** Use PostgreSQL with the pgvector extension for embedding storage
and similarity search, hosted on Supabase.

**Reasoning:**
- Leverages the developer's existing strong SQL/T-SQL background.
- Increasingly the real-world standard for small-to-mid scale production RAG
  systems.
- Free tier hosting available via Supabase; no new infrastructure paradigm.
- Single database for both relational metadata AND vectors.

**Alternatives Considered:**
- Pinecone / Weaviate: more scalable, but adds a second database system and
  less direct connection to existing skills. Rejected for this scale.
- SQL Server vector support: newer, less RAG-specific documentation. Rejected
  due to timeline risk.

**Date:** Project start

---

## D002 - Backend Framework: FastAPI (Python 3.12)

**Decision:** FastAPI over Flask or .NET/C#.

**Reasoning:**
- Python is the native ecosystem for AI/embeddings tooling.
- FastAPI provides async support, automatic docs, and type-hint validation.
- Developer has prior (rusty) Python exposure, weaker C# exposure.

**Alternatives Considered:**
- Flask: simpler, but lacks async and auto-docs out of the box.
- .NET/C#: would fight against the Python-first AI tooling ecosystem.

**Date:** Project start

---

## D003 - Document Corpus Scope: 8 Synthetic Documents

**Decision:** 8 synthetic manufacturing documents across 4 types (2 SOPs,
2 troubleshooting guides, 2 safety protocols, 2 KPI glossaries), ~300-600
words each.

**Reasoning:**
- Enough variation to make chunking strategy a real decision.
- Small enough to not consume days writing content.
- Sufficient for a compelling, varied live demo.

**Alternatives Considered:**
- 20-30+ documents: high time cost, little added portfolio value.
- 2-3 documents: too few to meaningfully demonstrate chunking/retrieval.

**Date:** Project start

---

## D004 - CI/CD Scope: Minimal (Lint + Basic Tests on Push)

**Decision:** A single GitHub Actions workflow running lint + core unit tests
on push. No multi-environment deployment pipeline.

**Reasoning:** Full CI/CD is disproportionate effort for a single-developer
portfolio project relative to the timeline.

**Date:** Project start

---

## D005 - Authentication: Out of Scope for v1

**Decision:** No user accounts, login, or session management in MUST HAVE scope.

**Reasoning:** Adds complexity and security surface with zero RAG/AI
demonstration value relative to cost. Deliberate, documented scope decision.

**Date:** Project start

---

## D006 - LLM Provider: OpenAI Only for v1 (Provider-Agnostic Interface)

**Decision:** Implement only OpenAI for v1; structure code behind a thin
interface so a second provider could be added later.

**Reasoning:** Multi-provider support is a good pattern to design for, but
fully implementing two providers doubles integration work for a "nice to
mention" feature, not a core demo requirement.

**Date:** Project start

---

## Template for Future Entries

```markdown
## D0XX - [Short Decision Title]

**Decision:** [What was decided]

**Reasoning:** [Why this was chosen]

**Alternatives Considered:**
- [Alternative 1]: [Why rejected]
- [Alternative 2]: [Why rejected]

**Date:** [Date or build phase]
```
'@

New-FileIfMissing -Path "README.md" -Content @'
# Manufacturing Knowledge Assistant

A Retrieval-Augmented Generation (RAG) application that answers natural
language questions about manufacturing operations - standard operating
procedures, troubleshooting guides, safety protocols, and KPI definitions -
grounded in a synthetic internal knowledge base.

**Live demo:** _[link to be added once deployed]_

**Status:** In active development - see DECISIONS.md for architectural
decisions and docs/ for full documentation.

---

## What This Project Demonstrates

This project demonstrates practical, end-to-end AI engineering skills:
retrieval-augmented generation, embeddings and vector search, LLM API
integration, full-stack development, and production deployment - using a
realistic (synthetic) manufacturing knowledge base as the use case.

It is intentionally scoped as a portfolio project, not a production system.
Every major scope decision is documented in DECISIONS.md, including what was
deliberately left out and why.

## How It Works

**Ingestion (one-time setup):**
Source documents -> chunked into overlapping segments -> each chunk embedded
via OpenAI -> chunks and vectors stored in PostgreSQL (pgvector).

**Query (every user question):**
User asks a question -> question is embedded -> pgvector similarity search
retrieves the most relevant chunks -> retrieved chunks + question assembled
into a prompt -> OpenAI generates an answer grounded in that context -> answer
and source citations returned to the user.

See docs/architecture.md for a full diagram and component breakdown.

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React, Vite, Tailwind CSS |
| Backend | FastAPI, Python 3.12 |
| Vector storage | PostgreSQL + pgvector (hosted on Supabase) |
| LLM | OpenAI (gpt-4o-mini) |
| Embeddings | OpenAI (text-embedding-3-small) |
| Deployment | Vercel (frontend), Render (backend), Supabase (database) |

Full reasoning for each choice is documented in DECISIONS.md.

## Getting Started

Full local setup instructions live in docs/development.md. Quick summary:

```bash
# Backend
cd backend
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
cp ../.env.example ../.env
uvicorn app.main:app --reload

# Frontend
cd frontend
npm install
npm run dev
```

## Project Documentation

- PROJECT_CHARTER.md - purpose, goals, and constraints
- DECISIONS.md - architectural decisions and rationale
- docs/architecture.md - system design and data flow
- docs/development.md - local development guide
- docs/deployment.md - production deployment details
- docs/future_enhancements.md - explicitly out-of-scope features and why

## Scope Note

This project uses entirely synthetic, fictional manufacturing documents. No
real company data, proprietary information, or personally identifiable
information is included anywhere in this repository.
'@

New-FileIfMissing -Path ".env.example" -Content @'
# Copy this file to .env and fill in real values.
# .env is gitignored and must never be committed.

# --- Database ---
DATABASE_URL=postgresql://user:password@host:port/dbname

# --- OpenAI ---
OPENAI_API_KEY=sk-your-key-here
EMBEDDING_MODEL=text-embedding-3-small
GENERATION_MODEL=gpt-4o-mini

# --- CORS / Frontend ---
FRONTEND_URL=http://localhost:5173

# --- Environment ---
ENVIRONMENT=development
'@

New-FileIfMissing -Path ".gitignore" -Content @'
# --- Secrets ---
.env
.env.local
.env.*.local

# --- Python ---
__pycache__/
*.py[cod]
*$py.class
venv/
env/
.venv/
*.egg-info/
.pytest_cache/
.ruff_cache/

# --- Node / Frontend ---
node_modules/
dist/
build/
.vite/

# --- OS / Editor ---
.DS_Store
Thumbs.db
.vscode/
.idea/
*.swp

# --- Logs ---
*.log
logs/

# --- Misc ---
.coverage
htmlcov/
'@

# -----------------------------
# docs/ files
# -----------------------------

New-FileIfMissing -Path "docs/architecture.md" -Content @'
# Architecture

This document describes the system's shape - its components, how they
communicate, and how data flows through the application. For *why* specific
technologies were chosen, see DECISIONS.md. This document covers *what* the
system looks like; DECISIONS.md covers *why* it looks that way.

---

## System Overview

The application has three deployed components:

| Component | Technology | Hosted on |
|---|---|---|
| Frontend | React + Vite + Tailwind | Vercel |
| Backend API | FastAPI (Python 3.12) | Render |
| Database | PostgreSQL + pgvector | Supabase |

The frontend never talks to the database directly - all data access happens
through the FastAPI backend. This keeps the database credentials and query
logic in one place, and means the frontend only needs to know about the
backend's API contract, not its storage internals.

---

## Data Flow: Ingestion

This happens once during setup, to load the synthetic document corpus into
the system.

```
Source documents (backend/data/source_documents/*.md)
        |
        v
Chunking service - splits each document into overlapping segments
        |
        v
Embedding service - calls OpenAI to convert each chunk into a vector
        |
        v
Database - chunk text + vector + metadata stored in PostgreSQL (pgvector)
```

Each stored chunk record includes: the chunk's raw text, its embedding vector,
which source document it came from, and any other metadata useful for
filtering or citation display (e.g., document type, position within document).

---

## Data Flow: Query

This happens every time a user asks a question through the frontend.

```
User types a question in the React chat interface
        |
        v
POST /query  ->  FastAPI backend
        |
        v
Embedding service - question is embedded using the same model used at ingestion
        |
        v
Retrieval service - pgvector similarity search returns top-k closest chunks
        |
        v
Generation service - retrieved chunks + question assembled into a prompt,
                       sent to OpenAI for generation
        |
        v
Response - answer + source chunk citations returned to frontend
        |
        v
React UI displays the answer and which document(s) it was grounded in
```

The backend never "asks the LLM to search" - retrieval is a separate step the
backend performs itself via vector similarity search *before* the LLM is ever
called. The LLM's only role is generation: producing a coherent answer from
the context it's handed.

---

## Component Responsibilities

**backend/app/routes/** - HTTP layer only. Validates incoming requests and
formats outgoing responses. Contains no business logic; delegates immediately
to services/.

**backend/app/services/** - Where the actual RAG pipeline logic lives, split
by stage:
- chunking.py - splits source documents into overlapping segments
- embeddings.py - generates vector embeddings (provider-agnostic interface
  per DECISIONS.md D006)
- retrieval.py - performs similarity search against stored vectors
- generation.py - constructs the final prompt and calls the LLM

**backend/app/db/** - Database models and connection handling, isolated so
the rest of the application doesn't need direct knowledge of the underlying
database technology.

**frontend/src/components/** - Chat interface, message display, and source
citation components.

**frontend/src/services/** - Handles outgoing API calls to the backend.

---

## Status of This Document

This describes the *intended* architecture as designed before implementation.
As backend and frontend code is built in later phases, this document should be
revisited and corrected if implementation reveals a better approach than what
was planned. Any deviation from this plan should be recorded as a new entry in
DECISIONS.md, not silently implemented.
'@

New-FileIfMissing -Path "docs/development.md" -Content @'
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
'@

New-FileIfMissing -Path "docs/deployment.md" -Content @'
# Deployment

How and where this application runs in production, and how deployments happen.

---

## Deployment Architecture

Three independent services, each deployed via native GitHub integration -
no custom deployment scripts or CI-driven deployment pipeline required.

| Component | Platform | Trigger |
|---|---|---|
| Frontend | Vercel | Push to main (auto-deploy via GitHub integration) |
| Backend | Render | Push to main (auto-deploy via GitHub integration) |
| Database | Supabase | Provisioned once; not redeployed on push |

This split is intentional - see DECISIONS.md for the reasoning behind each
platform choice. The deployment model is deliberately simple: each platform
watches the repository and deploys automatically, so there is no custom
deployment automation to build or maintain.

---

## Frontend (Vercel)

1. Connect the GitHub repository to a new Vercel project.
2. Set the root directory to frontend/.
3. Configure environment variables in the Vercel dashboard (the backend API
   URL the deployed frontend should call).
4. Every push to main triggers an automatic build and deploy.

Live URL: to be added once first deployed.

---

## Backend (Render)

1. Create a new Web Service on Render, connected to this repository.
2. Set the root directory to backend/.
3. Set the build command and start command (to be finalized once
   requirements.txt and the app entrypoint exist - expected to be
   "pip install -r requirements.txt" and
   "uvicorn app.main:app --host 0.0.0.0 --port $PORT").
4. Configure environment variables in the Render dashboard - see
   .env.example for the full list. Never commit real values to the repo.
5. Every push to main triggers an automatic build and deploy.

Live URL: to be added once first deployed.

---

## Database (Supabase)

1. Create a new Supabase project.
2. Enable the pgvector extension (Database -> Extensions -> enable "vector").
3. Copy the connection string into DATABASE_URL in both local .env and
   the Render dashboard environment variables.
4. Database schema/migrations: approach to be documented once
   backend/app/db/models.py is implemented.

---

## Environment Variables in Production

All variables listed in .env.example must be set directly in each platform's
dashboard (Vercel and Render). They are never committed to the repository.
See PROJECT_CHARTER.md and DECISIONS.md for the reasoning behind keeping
secret management this simple rather than introducing a dedicated secrets
manager - this project's scale does not warrant that added complexity.

---

## Deployment Checklist (for first deploy)

- [ ] Supabase project created, pgvector extension enabled
- [ ] Backend deployed to Render, environment variables set, health check passing
- [ ] Frontend deployed to Vercel, pointing at the live backend URL
- [ ] CORS configured on the backend to allow the deployed frontend origin
- [ ] End-to-end smoke test: ask a question through the live frontend and
      confirm a grounded answer with citations is returned
- [ ] Live URLs added to README.md and this document

---

## Status of This Document

This describes the intended deployment process. Specific build/start commands
and migration steps will be finalized and corrected here once backend and
frontend implementation is complete enough to actually deploy.
'@

New-FileIfMissing -Path "docs/future_enhancements.md" -Content @'
# Future Enhancements

This document lists features and improvements that were deliberately scoped
**out** of the initial version of this project, along with why. Its purpose
is to make clear that these are intentional decisions, not oversights -
scope discipline is itself part of what this project is meant to demonstrate.

See PROJECT_CHARTER.md for the project's stated non-goals, and DECISIONS.md
for the full reasoning behind each scoping decision below.

---

## Authentication & User Accounts

Not implemented in v1. Adds real complexity (session management, password
handling, security surface) with no RAG/AI demonstration value. If this
project were extended into something with real users, this would be the
first addition.

## Multi-Turn Conversation Memory

The current design treats every question independently - there is no chat
history carried between queries. A future version could maintain a
conversation history (similar to the messages array pattern used directly
with LLM APIs) so follow-up questions retain context from earlier in the
conversation.

## Multi-LLM Provider Support

The codebase is structured with a provider-agnostic interface for embeddings
and generation (see DECISIONS.md D006), but only OpenAI is actually wired up
in v1. Adding a second provider (e.g., Gemini) would be a contained change
given that interface, and is a reasonable next step.

## Admin UI for Document Management

Currently, adding or updating source documents requires manually editing
files in backend/data/source_documents/ and re-running ingestion. A future
version could add an authenticated admin interface for uploading, editing,
and re-ingesting documents without touching the filesystem directly.

## Hybrid Search (Keyword + Semantic)

The current retrieval approach is purely semantic (vector similarity). A
future enhancement could combine this with traditional keyword search, which
can catch exact-match cases (e.g., specific part numbers or codes) that
semantic search alone might rank lower than they deserve.

## Reranking Layer

A second-pass model that re-scores the top-N retrieved chunks for relevance
to the specific query, before passing only the best few to the LLM. This
generally improves answer quality and reduces token usage, but adds a new
model call and additional complexity not justified for the initial scope.

## Rate Limiting / Abuse Prevention

Beyond basic input length validation, there is no rate limiting on the
public API. Acceptable for a portfolio demo with limited expected traffic;
would need to be addressed before any real-world usage at scale.

## Hosted Vector Database Migration

If this project ever needed to scale meaningfully beyond a department-sized
knowledge base, migrating from pgvector to a dedicated vector database
(Pinecone, Weaviate, Qdrant) would be the natural next step. Not necessary at
current scale - see DECISIONS.md D001 for the full reasoning.

---

## How to Use This Document

When implementation reveals a good idea that doesn't fit the current scope,
add it here rather than implementing it immediately. This keeps the MUST HAVE
scope honest and prevents quiet scope creep during the build.
'@

Write-Host ""
Write-Host "Bootstrap complete. Safe to re-run anytime." -ForegroundColor Cyan
