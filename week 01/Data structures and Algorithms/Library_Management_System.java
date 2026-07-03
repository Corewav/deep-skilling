class Book {
    int bookId;
    String title;
    String author;

    Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    public void displayBook() {
        System.out.println("Book ID : " + bookId);
        System.out.println("Title : " + title);
        System.out.println("Author : " + author);
        System.out.println("----------------------------");
    }
}

class LibraryService {

    public Book linearSearch(Book[] books, String title) {

        for (Book book : books) {

            if (book.title.equalsIgnoreCase(title)) {
                return book;
            }
        }

        return null;
    }

    public Book binarySearch(Book[] books, String title) {

        int left = 0;
        int right = books.length - 1;

        while (left <= right) {

            int mid = left + (right - left) / 2;

            int result = books[mid].title.compareToIgnoreCase(title);

            if (result == 0) {
                return books[mid];
            } else if (result < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
}

public class Library_Management_System {

    public static void main(String[] args) {

        // Books are sorted alphabetically by title for Binary Search

        Book[] books = {
                new Book(101, "Atomic Habits", "James Clear"),
                new Book(102, "Clean Code", "Robert C. Martin"),
                new Book(103, "Design Patterns", "Erich Gamma"),
                new Book(104, "Effective Java", "Joshua Bloch"),
                new Book(105, "Introduction to Algorithms", "Thomas H. Cormen"),
                new Book(106, "Java Complete Reference", "Herbert Schildt"),
                new Book(107, "The Pragmatic Programmer", "Andrew Hunt")
        };

        LibraryService libraryService = new LibraryService();

        String searchTitle = "Effective Java";

        System.out.println("===== Linear Search =====");

        Book linearResult = libraryService.linearSearch(books, searchTitle);

        if (linearResult != null) {
            linearResult.displayBook();
        } else {
            System.out.println("Book not found.");
        }

        System.out.println();

        System.out.println("===== Binary Search =====");

        Book binaryResult = libraryService.binarySearch(books, searchTitle);

        if (binaryResult != null) {
            binaryResult.displayBook();
        } else {
            System.out.println("Book not found.");
        }
    }
}