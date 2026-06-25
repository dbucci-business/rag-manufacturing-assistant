import { useEffect, useRef } from "react";
import MessageBubble from "./MessageBubble";

export default function ChatWindow({ messages, loading }) {
  const bottomRef = useRef(null);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, loading]);

  return (
    <div className="chat-window">
      {messages.length === 0 && (
        <div className="empty-state">
          <p>Ask a question about manufacturing operations, SOPs, safety procedures, KPIs, or equipment.</p>
        </div>
      )}
      {messages.map((msg, i) => (
        <MessageBubble key={i} message={msg} />
      ))}
      {loading && (
        <div className="message message-assistant">
          <div className="message-label">Assistant</div>
          <div className="message-content loading">Thinking...</div>
        </div>
      )}
      <div ref={bottomRef} />
    </div>
  );
}
