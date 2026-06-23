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