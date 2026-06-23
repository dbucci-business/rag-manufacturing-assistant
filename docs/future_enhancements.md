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