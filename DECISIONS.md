# Architectural Decisions Log

This file records each architectural decision in the project: what I decided,
why, and what I considered and rejected. It's the reference for anyone working
in this repo, including AI coding assistants, so the reasoning behind the
system doesn't have to be rediscovered.

Format: Decision → Reasoning → Alternatives Considered → Date

---

## D001 - Vector Storage: PostgreSQL + pgvector

**Decision:** Store embeddings and run similarity search in PostgreSQL with the
pgvector extension, hosted on Supabase.

**Reasoning:**
- SQL is my strongest skill, so this let me work with vectors in a database I
  already know how to query and debug.
- pgvector is a common choice for small-to-mid scale RAG systems.
- One database holds both the document metadata and the vectors, so there's no
  second system to keep in sync.
- Supabase's free tier covers this project's scale.

**Alternatives Considered:**
- Pinecone / Weaviate: built to scale further, but they add a second database
  and move away from SQL. Not worth it at this size.
- SQL Server vector support: closer to what I use at work, but newer and with
  far less RAG-specific documentation. Too risky on a short timeline.

**Date:** [July 2026]

---

## D002 - Backend Framework: FastAPI (Python 3.12)

**Decision:** Use FastAPI for the backend instead of Flask or .NET/C#.

**Reasoning:**
- Python is where the AI and embeddings tooling lives.
- FastAPI gives async support, automatic API docs and type-hint validation
  without extra setup.
- My Python was rusty and my C# weaker, so Python was the better place to
  rebuild skills.

**Alternatives Considered:**
- Flask: simpler, but no async or auto-generated docs out of the box.
- .NET/C#: would mean working against the Python-first AI ecosystem.

**Date:** [July 2026]

---

## D003 - Document Corpus: 8 Synthetic Documents

**Decision:** Write 8 synthetic manufacturing documents across 4 types (2 SOPs,
2 troubleshooting guides, 2 safety protocols, 2 KPI glossaries), each about
300–600 words.

**Reasoning:**
- Enough variety in structure and length that chunking is a real decision
  (see D007).
- Small enough that writing content didn't take over the project.
- Varied enough for a convincing live demo.
- Synthetic, so no real company data is involved.

**Alternatives Considered:**
- 20–30+ documents: a lot of writing time for little added value at this stage.
- 2–3 documents: too few to show meaningful retrieval differences.

**Date:** [July 2026]

---

## D004 - CI/CD: Platform Auto-Deploy Only, No CI Pipeline in v1

**Decision:** No CI pipeline in v1. Vercel (frontend) and Render (backend)
redeploy automatically on every push to GitHub.

**Reasoning:** For a single-developer demo project, platform auto-deploy covers
getting changes live. A lint-and-test workflow is the natural next step once
the project has a test suite to run.

**Alternatives Considered:**
- GitHub Actions lint + test workflow: worth adding alongside tests, but not
  needed to ship v1.

**Date:** [July 2026]

---

## D005 - Authentication: Out of Scope for v1

**Decision:** No user accounts, login or session management in v1.

**Reasoning:** Authentication adds complexity and security surface without
showing anything about RAG. The demo works better when anyone can open it and
try it immediately.

**Date:** [July 2026]

---

## D006 - LLM Provider: OpenAI Only, Behind a Thin Interface

**Decision:** Implement only OpenAI in v1, but keep the calls behind a small
interface so another provider could be added later.

**Reasoning:** Designing for multiple providers is cheap; implementing two
doubles the integration work for a feature that isn't core to the demo.

**Date:** [July 2026]

---

## D007 - Chunking Strategy: Paragraph-Based Chunks (~300 Words, 2-Paragraph Overlap)

**Decision:** Build chunks from whole paragraphs up to ~300 words, with the last
2 paragraphs of each chunk repeated as the first 2 of the next
(`OVERLAP_PARAGRAPHS = 2` in chunking.py).

**Reasoning:**
- Splitting on paragraph boundaries means a chunk never cuts off mid-sentence or
  mid-step. In SOPs and troubleshooting guides, a paragraph is usually one
  complete step or case, so it's a natural unit.
- The documents run 300–600 words, so most end up as 1–3 chunks. Each retrieved
  chunk is about one thing instead of a whole document.
- The overlap keeps context that spans a chunk boundary, like a step that
  depends on the one before it, from being lost in both chunks.
- Tradeoff: because overlap is counted in paragraphs, the overlap in words varies
  with paragraph length. For this corpus, keeping steps intact mattered more
  than a fixed overlap size.
- Edge case: if a chunk holds only 1–2 long paragraphs, the next chunk starts
  one paragraph after the current one (`max(i + 1, j - OVERLAP_PARAGRAPHS)`).
  That guarantees the loop always moves forward, and in the one-paragraph case
  it means no overlap.

**Alternatives Considered:**
- Fixed word or token windows: guarantee a consistent size, but split sentences
  and steps wherever the count runs out.
- Embedding whole documents: simpler, but a 600-word SOP covers several topics,
  and one embedding for all of it would be too vague to retrieve the right part.
- Splitting on headings/sections: a good fit for SOPs, but section length varies
  a lot across my documents. Worth revisiting if the corpus grows.

**Date:** [July 2026]

---

## Template for Future Entries

```
## D0XX - [Short Decision Title]

**Decision:** [What was decided]

**Reasoning:** [Why this was chosen]

**Alternatives Considered:**
- [Alternative 1]: [Why rejected]
- [Alternative 2]: [Why rejected]

**Date:** [Date or build phase]
```
