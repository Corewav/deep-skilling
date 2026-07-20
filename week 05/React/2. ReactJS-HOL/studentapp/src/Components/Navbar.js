import { Link } from "react-router-dom";

function Navbar() {
    return ( <nav className="navbar"> <h2>Student Management Portal</h2>


            <div className="nav-links">
                <Link to="/">Home</Link>

                <Link to="/about">About</Link>

                <Link to="/contact">Contact</Link>

                <Link to="/students">Students</Link>

                <Link to="/add-student">Add Student</Link>
            </div>
        </nav>
    );


}

export default Navbar;
