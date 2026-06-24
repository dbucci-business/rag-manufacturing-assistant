from pathlib import Path

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.connection import get_db
from app.db.models import DocumentChunk
from app.services.chunking import load_and_chunk_documents
from app.services.embeddings import embed_text

router = APIRouter(prefix="/ingest", tags=["ingest"])

SOURCE_DIR = Path(__file__).parent.parent.parent / "data" / "source_documents"


@router.post("")
async def ingest(db: Session = Depends(get_db)):
    chunks = load_and_chunk_documents(SOURCE_DIR)

    db.query(DocumentChunk).delete()
    db.commit()

    for chunk_data in chunks:
        embedding = await embed_text(chunk_data["content"])
        db.add(DocumentChunk(
            source_document=chunk_data["source_document"],
            chunk_index=chunk_data["chunk_index"],
            content=chunk_data["content"],
            embedding=embedding,
        ))

    db.commit()
    return {"status": "ok", "chunks_ingested": len(chunks)}
