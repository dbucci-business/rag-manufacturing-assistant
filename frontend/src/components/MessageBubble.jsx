import SourceCitations from "./SourceCitations";

export default function MessageBubble({ message }) {
  const isUser = message.role === "user";

  return (
    <div className={`message ${isUser ? "message-user" : "message-assistant"}`}>
      <div className="message-label">{isUser ? "You" : "Assistant"}</div>
      <div className="message-content">{message.content}</div>
      {!isUser && message.sources && <SourceCitations sources={message.sources} />}
    </div>
  );
}
