import CurrencyConvertor from "./Components/CurrencyConvertor";
import { useState } from "react";
import "./App.css";

function App() {
  const [count, setCount] = useState(0);
  const [message, setMessage] = useState("");

  // Increment counter
  const increment = () => {
    setCount(count + 1);
  };

  // Say Hello
  const sayHello = () => {
    setMessage("Hello! Welcome to React Events");
  };

  // Multiple methods
  const handleIncrement = () => {
    increment();
    sayHello();
  };

  // Decrement counter
  const decrement = () => {
    setCount(count - 1);
  };

  // Welcome function with argument
  const sayWelcome = (message) => {
    setMessage(message);
  };

  // Synthetic event
  const handlePress = (event) => {
    setMessage("I was clicked");
    console.log(event);
  };


  return (
      <div className="app-container">
        <h1>React Event Examples</h1>

        {/* Counter */}
        <div className="section">
          <h2>Counter</h2>

          <h3>{count}</h3>

          <button onClick={handleIncrement}>
            Increment
          </button>

          <button onClick={decrement}>
            Decrement
          </button>

          <p>{message}</p>
        </div>

        {/* Say Welcome */}
        <div className="section">
          <h2>Welcome Message</h2>

          <button onClick={() => sayWelcome("Welcome to React")}>
            Say Welcome
          </button>
        </div>

        {/* Synthetic Event */}
        <div className="section">
          <h2>Synthetic Event</h2>

          <button onClick={handlePress}>
            OnPress
          </button>
        </div>

        {/* Synthetic Event */}
        <div className="section">
          <h2>Synthetic Event</h2>

          <button onClick={handlePress}>
            OnPress
          </button>
        </div>

        <CurrencyConvertor />

      </div>
  );
}

export default App;