import { useState } from "react";

function AddStudent({ addStudent }) {
    const [name, setName] = useState("");
    const [course, setCourse] = useState("");
    const [email, setEmail] = useState("");


const handleSubmit = (event) => {
    event.preventDefault();

    const newStudent = {
        id: Date.now(),
        name: name,
        course: course,
        email: email,
    };

    addStudent(newStudent);

    alert("Student Added Successfully!");

    setName("");
    setCourse("");
    setEmail("");
};

return (
    <div className="page-container">
        <div className="form-card">
            <h1>Add New Student</h1>

            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label>Student Name</label>
                    <input
                        type="text"
                        value={name}
                        onChange={(event) =>
                            setName(event.target.value)
                        }
                        required
                    />
                </div>

                <div className="form-group">
                    <label>Course</label>
                    <input
                        type="text"
                        value={course}
                        onChange={(event) =>
                            setCourse(event.target.value)
                        }
                        required
                    />
                </div>

                <div className="form-group">
                    <label>Email</label>
                    <input
                        type="email"
                        value={email}
                        onChange={(event) =>
                            setEmail(event.target.value)
                        }
                        required
                    />
                </div>

                <button type="submit">
                    Add Student
                </button>
            </form>
        </div>
    </div>
);


}

export default AddStudent;
