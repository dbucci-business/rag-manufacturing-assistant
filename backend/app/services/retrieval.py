from typing import List

from sqlalchemy.orm import Session

from app.db.models import DocumentChunk


def retrieve_chunks(db: Session, query_embedding: List[float], top_k: int = 5) -> List[DocumentChunk]:
    return (
        db.query(DocumentChunk)
        .order_by(DocumentChunk.embedding.cosine_distance(query_embedding))
        .limit(top_k)
        .all()
    )
