from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.connection import get_db
from app.schemas.query import QueryRequest, QueryResponse, SourceChunk
from app.services.embeddings import embed_text
from app.services.generation import generate_answer
from app.services.retrieval import retrieve_chunks

router = APIRouter(prefix="/query", tags=["query"])


@router.post("", response_model=QueryResponse)
async def query(request: QueryRequest, db: Session = Depends(get_db)):
    question_embedding = await embed_text(request.question)
    chunks = retrieve_chunks(db, question_embedding, top_k=5)

    if not chunks:
        raise HTTPException(status_code=404, detail="No relevant documents found.")

    answer = await generate_answer(request.question, chunks)

    return QueryResponse(
        answer=answer,
        sources=[
            SourceChunk(
                source_document=chunk.source_document,
                chunk_index=chunk.chunk_index,
                content=chunk.content,
            )
            for chunk in chunks
        ],
    )
