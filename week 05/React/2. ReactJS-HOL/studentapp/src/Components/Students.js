import { useState } from "react";

function Students({
                      students,
                      deleteStudent,
                      updateStudent,
                      isLoading,
                      error
                  }) {
    const [editingStudent, setEditingStudent] = useState(null);
    const [searchTerm, setSearchTerm] = useState("");


const filteredStudents = students.filter((student) =>
    student.name
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
    student.course
        .toLowerCase()
        .includes(searchTerm.toLowerCase())
);

if (isLoading) {
    return (
        <div className="page-container">
            <h2>Loading students...</h2>
        </div>
    );
}

if (error) {
    return (
        <div className="page-container">
            <h2>{error}</h2>
        </div>
    );
}

return (
    <div className="page-container">
        <h1>Student List</h1>

        <p>
            Total Students: {students.length}
        </p>

        <input
            type="text"
            placeholder="Search by name or course..."
            value={searchTerm}
            onChange={(event) =>
                setSearchTerm(event.target.value)
            }
        />

        <table className="student-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Course</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                {filteredStudents.map((student) => (
                    <tr key={student.id}>
                        <td>{student.id}</td>
                        <td>{student.name}</td>
                        <td>{student.course}</td>
                        <td>{student.email}</td>

                        <td>
                            <button
                                className="edit-btn"
                                onClick={() =>
                                    setEditingStudent({
                                        ...student
                                    })
                                }
                            >
                                Edit
                            </button>

                            <button
                                className="delete-btn"
                                onClick={() => {
                                    const confirmDelete =
                                        window.confirm(
                                            "Are you sure you want to delete this student?"
                                        );

                                    if (confirmDelete) {
                                        deleteStudent(student.id);
                                    }
                                }}
                            >
                                Delete
                            </button>
                        </td>
                    </tr>
                ))}
            </tbody>
        </table>

        {filteredStudents.length === 0 && (
            <div className="empty-state">
                <h2>No Students Found</h2>

                <p>
                    No student matches your search.
                </p>
            </div>
        )}

        {editingStudent && (
            <div className="edit-form-card">
                <h2>Edit Student</h2>

                <form
                    onSubmit={(event) => {
                        event.preventDefault();

                        updateStudent(editingStudent);

                        setEditingStudent(null);
                    }}
                >
                    <div className="form-group">
                        <label>Name</label>

                        <input
                            type="text"
                            value={editingStudent.name}
                            onChange={(event) =>
                                setEditingStudent({
                                    ...editingStudent,
                                    name: event.target.value
                                })
                            }
                            required
                        />
                    </div>

                    <div className="form-group">
                        <label>Course</label>

                        <input
                            type="text"
                            value={editingStudent.course}
                            onChange={(event) =>
                                setEditingStudent({
                                    ...editingStudent,
                                    course: event.target.value
                                })
                            }
                            required
                        />
                    </div>

                    <div className="form-group">
                        <label>Email</label>

                        <input
                            type="email"
                            value={editingStudent.email}
                            onChange={(event) =>
                                setEditingStudent({
                                    ...editingStudent,
                                    email: event.target.value
                                })
                            }
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        className="update-btn"
                    >
                        Update Student
                    </button>

                    <button
                        type="button"
                        className="cancel-btn"
                        onClick={() =>
                            setEditingStudent(null)
                        }
                    >
                        Cancel
                    </button>
                </form>
            </div>
        )}
    </div>
);


}

export default Students;
