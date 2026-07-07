package com.library.LibraryManagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.library.LibraryManagement.model.Book;

public interface BookRepository extends JpaRepository<Book, Long> {
}