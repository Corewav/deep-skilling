import CalculateScore from "./Components/CalculateScore";
import "./App.css";

function App() {
    return (
        <div className="app-container">

            <h1>Student Score Calculator</h1>

            <CalculateScore
                name="Mihir Bansal"
                school="GLA University"
                total={850}
                goal={1000}
            />

            <CalculateScore
                name="Rahul Sharma"
                school="ABC School"
                total={720}
                goal={1000}
            />

            <CalculateScore
                name="Priya Singh"
                school="XYZ School"
                total={920}
                goal={1000}
            />

        </div>
    );
}

export default App;