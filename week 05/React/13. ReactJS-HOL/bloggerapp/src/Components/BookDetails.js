function BookDetails({ book }) {
    return (
        <div className="card">
            <h2>Book Details</h2>

            <h3>{book.title}</h3>
            <p>Author: {book.author}</p>
            <p>Price: ₹{book.price}</p>
        </div>
    );
}

export default BookDetails;