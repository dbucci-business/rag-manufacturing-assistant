import os
from typing import List

from dotenv import load_dotenv
from openai import AsyncOpenAI

from app.db.models import DocumentChunk

load_dotenv()

_client = AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY"))
_model = os.getenv("GENERATION_MODEL", "gpt-4o-mini")

_SYSTEM_PROMPT = (
    "You are a knowledgeable assistant for Vulcan Tire Corporation's manufacturing operations. "
    "Answer questions using only the provided context from internal documents. "
    "If the context does not contain enough information to answer, say so clearly. "
    "Be precise and reference specific procedures, codes, or values when available."
)


async def generate_answer(question: str, chunks: List[DocumentChunk]) -> str:
    context = "\n\n---\n\n".join(
        f"[Source: {chunk.source_document}]\n{chunk.content}" for chunk in chunks
    )

    response = await _client.chat.completions.create(
        model=_model,
        messages=[
            {"role": "system", "content": _SYSTEM_PROMPT},
            {
                "role": "user",
                "content": f"Context:\n\n{context}\n\nQuestion: {question}",
            },
        ],
        temperature=0.1,
    )

    return response.choices[0].message.content
