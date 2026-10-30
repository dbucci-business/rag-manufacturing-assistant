# Project Charter: Manufacturing Knowledge Assistant

## Purpose
A Retrieval-Augmented Generation (RAG) application that answers natural-language
questions about manufacturing operations (SOPs, troubleshooting guides, safety
protocols and KPI definitions) using a synthetic document corpus that simulates
an internal enterprise knowledge base.

## Why This Project Exists
I built this to learn how RAG systems work end to end: chunking, embeddings,
vector search, LLM integration and deployment. I grounded it in manufacturing
because that's the domain I work in as a data analyst, where plant knowledge
often lives in scattered documents and in people's heads. That makes a knowledge
assistant a realistic use case rather than a toy one.

## How It Was Built
This project uses AI-assisted development. I wrote the source documents, made
the architectural decisions (recorded in DECISIONS.md), chose the chunking
strategy and set up hosting across Vercel, Render and Supabase. AI coding tools
wrote much of the implementation, directed by this charter and the decision log.

## Goals (in priority order)
1. A working, end-to-end RAG pipeline anyone can try live
2. Every architectural decision understood, documented and defensible
3. Deployed and publicly accessible, not just runnable locally
4. Clean, documented project structure
5. A foundation to extend with the enhancements listed below

## Non-Goals
- Not a production system handling real manufacturing data
- Not an attempt at the most sophisticated RAG architecture possible
- Not a multi-tenant or authenticated system
- Not optimized for scale beyond demo-level usage

## Success Criteria
- Deployed and reachable at a public URL
- Answers questions grounded in the synthetic document set, with source citations
- Every pipeline decision is documented in DECISIONS.md
- A newcomer can understand the repository in 10 minutes
- README includes a working demo link, architecture diagram and setup steps

## Out of Scope (details in docs/future_enhancements.md)
- Authentication and user accounts
- Multi-LLM provider support (the architecture allows it; not implemented in v1)
- Conversation history and multi-turn memory
- Admin dashboard for document management

## Working in This Repo
Read this charter first, before the code, DECISIONS.md or the architecture docs.
If a proposed change conflicts with the goals or non-goals above, resolve that
conflict before making the change. This applies to human contributors and to
AI coding assistants alike.
