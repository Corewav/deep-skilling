function About() {
    return (
        <div className="page-container">
            <div className="info-card">
                <h1>About Student Management Portal</h1>

                <p>
                    The Student Management Portal is a React-based web
                    application designed to manage student records
                    efficiently.
                </p>

                <p>
                    This application allows users to add, view, search,
                    update, and delete student records.
                </p>

                <h2>Features</h2>

                <ul>
                    <li>Student record management</li>
                    <li>Add new students</li>
                    <li>Edit existing student information</li>
                    <li>Delete student records</li>
                    <li>Search students by name or course</li>
                    <li>Data persistence using localStorage</li>
                    <li>API integration using Fetch API</li>
                    <li>Responsive user interface</li>
                </ul>

                <h2>Technologies Used</h2>

                <div className="technology-list">
                    <span>React.js</span>
                    <span>React Router</span>
                    <span>JavaScript</span>
                    <span>HTML</span>
                    <span>CSS</span>
                    <span>REST API</span>
                </div>
            </div>
        </div>
    );
}

export default About;