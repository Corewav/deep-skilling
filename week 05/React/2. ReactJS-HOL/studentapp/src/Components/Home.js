import { Link } from "react-router-dom";

function Home() {
    return (
        <div className="page-container">
            <div className="hero-section">
                <h1>Student Management Portal</h1>

                <p>
                    Manage student records easily and efficiently.
                </p>

                <Link
                    to="/students"
                    className="primary-button"
                >
                    View Students
                </Link>
            </div>

            <div className="dashboard-cards">
                <Link
                    to="/students"
                    className="card-link"
                >
                    <div className="card">
                        <h2>Students</h2>

                        <p>
                            View and manage all student records.
                        </p>
                    </div>
                </Link>

                <Link
                    to="/add-student"
                    className="card-link"
                >
                    <div className="card">
                        <h2>Add Student</h2>

                        <p>
                            Add a new student to the portal.
                        </p>
                    </div>
                </Link>

                <Link
                    to="/about"
                    className="card-link"
                >
                    <div className="card">
                        <h2>About Portal</h2>

                        <p>
                            Learn more about this application.
                        </p>
                    </div>
                </Link>
            </div>
        </div>
    );
}

export default Home;