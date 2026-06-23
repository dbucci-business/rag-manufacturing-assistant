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