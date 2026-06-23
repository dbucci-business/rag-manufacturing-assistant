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