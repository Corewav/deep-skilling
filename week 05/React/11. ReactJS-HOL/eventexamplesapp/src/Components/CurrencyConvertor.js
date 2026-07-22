import { useState } from "react";

function CurrencyConvertor() {
    const [rupees, setRupees] = useState("");
    const [euros, setEuros] = useState("");

    const handleSubmit = (event) => {
        event.preventDefault();

        const euroValue = Number(rupees) / 90;

        setEuros(euroValue.toFixed(2));
    };

    return (
        <div className="section">
            <h2>Currency Convertor</h2>

            <form onSubmit={handleSubmit}>
                <input
                    type="number"
                    placeholder="Enter Rupees"
                    value={rupees}
                    onChange={(event) =>
                        setRupees(event.target.value)
                    }
                />

                <br />
                <br />

                <button type="submit">
                    Convert
                </button>
            </form>

            {euros && (
                <p>
                    Euro Value: €{euros}
                </p>
            )}
        </div>
    );
}

export default CurrencyConvertor;