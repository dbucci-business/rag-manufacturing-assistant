from pydantic import BaseModel, Field
from typing import List


class QueryRequest(BaseModel):
    question: str = Field(..., min_length=1, max_length=1000)


class SourceChunk(BaseModel):
    source_document: str
    chunk_index: int
    content: str


class QueryResponse(BaseModel):
    answer: str
    sources: List[SourceChunk]
