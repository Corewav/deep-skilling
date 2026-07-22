import ListofPlayers from "./Components/ListofPlayers";
import IndianPlayers from "./Components/IndianPlayers";
import "./App.css";

function App() {
  const flag = true;

  return (
      <div className="app-container">
        <h1>Indian Cricket Players</h1>

        {flag ? <ListofPlayers /> : <IndianPlayers />}
      </div>
  );
}

export default App;