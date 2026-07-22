import BookDetails from "./Components/BookDetails";
import BlogDetails from "./Components/BlogDetails";
import CourseDetails from "./Components/CourseDetails";
import "./App.css";

function App() {
  const books = [
    {
      id: 1,
      title: "Java Programming",
      author: "James Gosling",
      price: 500
    },
    {
      id: 2,
      title: "React Basics",
      author: "React Team",
      price: 700
    }
  ];

  const blogs = [
    {
      id: 1,
      title: "Learning React",
      author: "Mihir Bansal",
      description: "React is a JavaScript library for building user interfaces."
    },
    {
      id: 2,
      title: "Understanding JavaScript",
      author: "Corewav",
      description: "JavaScript is used to create interactive web applications."
    }
  ];

  const courses = [
    {
      id: 1,
      name: "Full Stack Java",
      trainer: "Cognizant",
      duration: "6 Months"
    },
    {
      id: 2,
      name: "React Development",
      trainer: "Cognizant",
      duration: "2 Months"
    }
  ];

  // Conditional Rendering using if-else
  let courseContent;

  if (courses.length > 0) {
    courseContent = courses.map((course) => (
        <CourseDetails
            key={course.id}
            course={course}
        />
    ));
  } else {
    courseContent = <p>No courses available</p>;
  }

  return (
      <div className="app-container">

        <h1>Blogger Application</h1>

        {/* Book Details - map() and key */}
        <div className="section">
          <h2>Books</h2>

          {books.length > 0 && (
              <p>Books are available</p>
          )}

          {books.map((book) => (
              <BookDetails
                  key={book.id}
                  book={book}
              />
          ))}
        </div>

        {/* Blog Details - Ternary Conditional Rendering */}
        <div className="section">
          <h2>Blogs</h2>

          {blogs.length > 0 ? (
              blogs.map((blog) => (
                  <BlogDetails
                      key={blog.id}
                      blog={blog}
                  />
              ))
          ) : (
              <p>No blogs available</p>
          )}
        </div>

        {/* Course Details - if-else Conditional Rendering */}
        <div className="section">
          <h2>Courses</h2>

          {courseContent}
        </div>

      </div>
  );
}

export default App;