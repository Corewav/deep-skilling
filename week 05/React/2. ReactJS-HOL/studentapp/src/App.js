import { useState, useEffect } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Home from "./Components/Home";
import About from "./Components/About";
import Contact from "./Components/Contact";
import Students from "./Components/Students";
import AddStudent from "./Components/AddStudent";
import Navbar from "./Components/Navbar";

import "./App.css";

function App() {
    const [students, setStudents] = useState(() => {
        const savedStudents = localStorage.getItem("students");


    return savedStudents
        ? JSON.parse(savedStudents)
        : [
            {
                id: 1,
                name: "Mihir Bansal",
                course: "Computer Science",
                email: "mihir@cognizant.com",
            },
            {
                id: 2,
                name: "Rahul Sharma",
                course: "Information Technology",
                email: "rahul@cognizant.com",
            },
            {
                id: 3,
                name: "Priya Singh",
                course: "Computer Science",
                email: "priya@cognizant.com",
            },
        ];
});

const [isLoading, setIsLoading] = useState(true);
const [error, setError] = useState("");

useEffect(() => {
    localStorage.setItem("students", JSON.stringify(students));
}, [students]);

useEffect(() => {
    fetch("https://jsonplaceholder.typicode.com/users")
        .then((response) => {
            if (!response.ok) {
                throw new Error("Failed to fetch students");
            }

            return response.json();
        })
        .then((data) => {
            const formattedStudents = data.map((user) => ({
                id: user.id,
                name: user.name,
                course: "Computer Science",
                email: user.email,
            }));

            setStudents(formattedStudents);
            setIsLoading(false);
        })
        .catch((error) => {
            console.error("Error fetching students:", error);
            setError("Failed to load students");
            setIsLoading(false);
        });
}, []);

const addStudent = (student) => {
    setStudents([...students, student]);
};

const deleteStudent = (id) => {
    setStudents(
        students.filter((student) => student.id !== id)
    );
};

const updateStudent = (updatedStudent) => {
    setStudents(
        students.map((student) =>
            student.id === updatedStudent.id
                ? updatedStudent
                : student
        )
    );
};

return (
    <BrowserRouter>
        <Navbar />

        <Routes>
            <Route
                path="/"
                element={<Home />}
            />

            <Route
                path="/about"
                element={<About />}
            />

            <Route
                path="/contact"
                element={<Contact />}
            />

            <Route
                path="/students"
                element={
                    <Students
                        students={students}
                        deleteStudent={deleteStudent}
                        updateStudent={updateStudent}
                        isLoading={isLoading}
                        error={error}
                    />
                }
            />

            <Route
                path="/add-student"
                element={
                    <AddStudent
                        addStudent={addStudent}
                    />
                }
            />
        </Routes>
    </BrowserRouter>
);


    }

    export default App;
