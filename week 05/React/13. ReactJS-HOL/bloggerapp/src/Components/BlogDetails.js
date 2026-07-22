function BlogDetails({ blog }) {
    return (
        <div className="card">
            <h2>Blog Details</h2>

            <h3>{blog.title}</h3>
            <p>Author: {blog.author}</p>
            <p>{blog.description}</p>
        </div>
    );
}

export default BlogDetails;