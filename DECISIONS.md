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