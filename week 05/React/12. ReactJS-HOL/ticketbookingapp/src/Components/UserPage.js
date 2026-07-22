function UserPage({ logout }) {
    return (
        <div className="page-card">
            <h2>Welcome User</h2>

            <p>You are logged in.</p>

            <h3>Flight Booking</h3>

            <p>Delhi → Mumbai</p>
            <p>Price: ₹5,000</p>

            <button onClick={() => alert("Ticket booked successfully!")}>
                Book Ticket
            </button>

            <button onClick={logout}>
                Logout
            </button>
        </div>
    );
}

export default UserPage;