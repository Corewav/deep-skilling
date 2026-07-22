import { useState } from "react";
import GuestPage from "./Components/GuestPage";
import UserPage from "./Components/UserPage";
import "./App.css";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const login = () => {
    setIsLoggedIn(true);
  };

  const logout = () => {
    setIsLoggedIn(false);
  };

  let page;

  if (isLoggedIn) {
    page = <UserPage logout={logout} />;
  } else {
    page = <GuestPage login={login} />;
  }

  return (
      <div className="app-container">
        <h1>Ticket Booking Application</h1>

        {page}
      </div>
  );
}

export default App;