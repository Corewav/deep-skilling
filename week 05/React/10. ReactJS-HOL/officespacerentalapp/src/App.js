import React from "react";
import "./App.css";

function App() {
  const officeSpace = [
    {
      name: "Skyline Business Center",
      rent: 55000,
      address: "Mathura, Uttar Pradesh",
      image: "/office1.jpg"
    },
    {
      name: "Tech Park Office",
      rent: 75000,
      address: "Noida, Uttar Pradesh",
      image: "/office2.jpg"
    },
    {
      name: "Corporate Hub",
      rent: 45000,
      address: "Delhi, India",
      image: "/office.jpg"
    }
  ];

  return (
      <div className="app-container">

        <h1>Office Space Rental App</h1>

        <div className="office-container">

          {officeSpace.map((office) => (

              <div className="office-card" key={office.name}>

                <img
                    src={office.image}
                    alt={office.name}
                />

                <h2>{office.name}</h2>

                <p>
                  <strong>Address:</strong>{" "}
                  {office.address}
                </p>

                <p
                    className={
                      office.rent < 60000
                          ? "low-rent"
                          : "high-rent"
                    }
                >
                  <strong>Rent:</strong>{" "}
                  ₹{office.rent}
                </p>

              </div>

          ))}

        </div>

      </div>
  );
}

export default App;