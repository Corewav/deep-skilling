function CourseDetails({ course }) {
    return (
        <div className="card">
            <h2>Course Details</h2>

            <h3>{course.name}</h3>
            <p>Trainer: {course.trainer}</p>
            <p>Duration: {course.duration}</p>
        </div>
    );
}

export default CourseDetails;