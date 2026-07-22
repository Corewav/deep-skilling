function GuestPage({ login }) {
    return (
        <div className="page-card">
            <h2>Welcome Guest</h2>

            <p>Please login to book your flight ticket.</p>

            <h3>Available Flight</h3>

            <p>Delhi → Mumbai</p>
            <p>Price: ₹5,000</p>

            <button onClick={login}>
                Login
            </button>
        </div>
    );
}

export default GuestPage;