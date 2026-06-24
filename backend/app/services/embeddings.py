import os
from typing import List

from dotenv import load_dotenv
from openai import AsyncOpenAI

load_dotenv()

_client = AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY"))
_model = os.getenv("EMBEDDING_MODEL", "text-embedding-3-small")


async def embed_text(text: str) -> List[float]:
    response = await _client.embeddings.create(model=_model, input=text)
    return response.data[0].embedding
