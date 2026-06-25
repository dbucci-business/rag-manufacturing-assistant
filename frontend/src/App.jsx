import { useState } from "react";
import ChatWindow from "./components/ChatWindow";
import ChatInput from "./components/ChatInput";
import { sendQuery } from "./services/api";
import "./App.css";

export default function App() {
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  async function handleSend(question) {
    setError(null);
    setMessages((prev) => [...prev, { role: "user", content: question }]);
    setLoading(true);

    try {
      const data = await sendQuery(question);
      setMessages((prev) => [
        ...prev,
        { role: "assistant", content: data.answer, sources: data.sources },
      ]);
    } catch {
      setError("Something went wrong. Make sure the backend is running.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="app">
      <header className="header">
        <h1>Manufacturing Knowledge Assistant</h1>
        <p>Vulcan Tire Corporation — Internal Operations Q&A</p>
      </header>
      <main className="main">
        <ChatWindow messages={messages} loading={loading} />
        {error && <div className="error">{error}</div>}
        <ChatInput onSend={handleSend} disabled={loading} />
      </main>
    </div>
  );
}
