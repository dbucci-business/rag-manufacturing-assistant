import { useState } from "react";

export default function SourceCitations({ sources }) {
  const [expanded, setExpanded] = useState(false);

  if (!sources || sources.length === 0) return null;

  return (
    <div className="sources">
      <button className="sources-toggle" onClick={() => setExpanded(!expanded)}>
        {expanded ? "▾" : "▸"} Sources ({sources.length})
      </button>
      {expanded && (
        <div className="sources-list">
          {sources.map((source, i) => (
            <div key={i} className="source-item">
              <div className="source-name">
                {source.source_document.replace(/_/g, " ")}
              </div>
              <div className="source-content">{source.content}</div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
