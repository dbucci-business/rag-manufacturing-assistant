import re
from pathlib import Path
from typing import Dict, List

MAX_WORDS_PER_CHUNK = 300
OVERLAP_PARAGRAPHS = 2


def load_and_chunk_documents(source_dir: Path) -> List[Dict]:
    chunks = []
    for filepath in sorted(source_dir.glob("*.md")):
        text = filepath.read_text(encoding="utf-8")
        chunks.extend(chunk_document(text, filepath.stem))
    return chunks


def chunk_document(text: str, source_document: str) -> List[Dict]:
    paragraphs = [p.strip() for p in re.split(r"\n{2,}", text) if p.strip()]

    chunks = []
    chunk_index = 0
    i = 0

    while i < len(paragraphs):
        current_paras = []
        word_count = 0
        j = i

        while j < len(paragraphs) and word_count < MAX_WORDS_PER_CHUNK:
            current_paras.append(paragraphs[j])
            word_count += len(paragraphs[j].split())
            j += 1

        content = "\n\n".join(current_paras).strip()
        if content:
            chunks.append({
                "source_document": source_document,
                "chunk_index": chunk_index,
                "content": content,
            })
            chunk_index += 1

        i = max(i + 1, j - OVERLAP_PARAGRAPHS)

    return chunks
