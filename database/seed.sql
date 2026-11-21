USE library_management_system;

START TRANSACTION;

-- 1. Demonstration user accounts
INSERT INTO users (full_name, email, password_hash, role)
SELECT 'System Administrator', 'admin@library.test', '$2y$12$JjDyc/Yv97oA3nP2UV4qeujIzVsoz6l.hvh/31rp8rXvbfubLQLay', 'administrator'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'admin@library.test'
);

INSERT INTO users (full_name, email, password_hash, role)
SELECT 'Library Librarian', 'librarian@library.test', '$2y$12$JjDyc/Yv97oA3nP2UV4qeujIzVsoz6l.hvh/31rp8rXvbfubLQLay', 'librarian'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'librarian@library.test'
);

INSERT INTO users (full_name, email, password_hash, role)
SELECT 'Alex Morgan', 'alex@library.test', '$2y$12$JjDyc/Yv97oA3nP2UV4qeujIzVsoz6l.hvh/31rp8rXvbfubLQLay', 'member'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'alex@library.test'
);

INSERT INTO users (full_name, email, password_hash, role)
SELECT 'Jamie Taylor', 'jamie@library.test', '$2y$12$JjDyc/Yv97oA3nP2UV4qeujIzVsoz6l.hvh/31rp8rXvbfubLQLay', 'member'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'jamie@library.test'
);

-- 2. Member profiles
INSERT INTO members (user_id, student_id, department, phone)
SELECT user_id, 'DEMO-001', 'Computer Science', '0000000001'
FROM users
WHERE email = 'alex@library.test'
AND NOT EXISTS (
    SELECT 1 FROM members WHERE student_id = 'DEMO-001'
);

INSERT INTO members (user_id, student_id, department, phone)
SELECT user_id, 'DEMO-002', 'Software Engineering', '0000000002'
FROM users
WHERE email = 'jamie@library.test'
AND NOT EXISTS (
    SELECT 1 FROM members WHERE student_id = 'DEMO-002'
);

-- 3. Book categories
INSERT INTO categories (category_name, description)
SELECT 'Computer Science', 'Programming and computing books'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE category_name = 'Computer Science'
);

INSERT INTO categories (category_name, description)
SELECT 'Database Systems', 'Database design and management books'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE category_name = 'Database Systems'
);

INSERT INTO categories (category_name, description)
SELECT 'Artificial Intelligence', 'Artificial intelligence and machine learning books'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE category_name = 'Artificial Intelligence'
);

INSERT INTO categories (category_name, description)
SELECT 'Software Engineering', 'Software development and engineering books'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE category_name = 'Software Engineering'
);

-- 4. Authors
INSERT INTO authors (author_name)
SELECT 'Robert C. Martin'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE author_name = 'Robert C. Martin');

INSERT INTO authors (author_name)
SELECT 'Thomas H. Cormen'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE author_name = 'Thomas H. Cormen');

INSERT INTO authors (author_name)
SELECT 'Abraham Silberschatz'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE author_name = 'Abraham Silberschatz');

INSERT INTO authors (author_name)
SELECT 'Stuart Russell'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE author_name = 'Stuart Russell');

-- 5. Books
INSERT INTO books (category_id, isbn, title, publisher, publication_year, description)
SELECT c.category_id, '9780132350884',
       'Clean Code', 'Prentice Hall', 2008,
       'A handbook of agile software craftsmanship.'
FROM categories c
WHERE c.category_name = 'Software Engineering'
AND NOT EXISTS (SELECT 1 FROM books WHERE isbn = '9780132350884');

INSERT INTO books (category_id, isbn, title, publisher, publication_year, description)
SELECT c.category_id, '9780262033848',
       'Introduction to Algorithms', 'MIT Press', 2009,
       'A comprehensive introduction to algorithms.'
FROM categories c
WHERE c.category_name = 'Computer Science'
AND NOT EXISTS (SELECT 1 FROM books WHERE isbn = '9780262033848');

INSERT INTO books (category_id, isbn, title, publisher, publication_year, description)
SELECT c.category_id, '9780073523323',
       'Database System Concepts', 'McGraw-Hill', 2010,
       'Fundamental concepts of database systems.'
FROM categories c
WHERE c.category_name = 'Database Systems'
AND NOT EXISTS (SELECT 1 FROM books WHERE isbn = '9780073523323');

INSERT INTO books (category_id, isbn, title, publisher, publication_year, description)
SELECT c.category_id, '9780136042594',
       'Artificial Intelligence: A Modern Approach', 'Pearson', 2010,
       'An introduction to artificial intelligence.'
FROM categories c
WHERE c.category_name = 'Artificial Intelligence'
AND NOT EXISTS (SELECT 1 FROM books WHERE isbn = '9780136042594');

-- 6. Book-author relationships
INSERT INTO book_authors (book_id, author_id)
SELECT b.book_id, a.author_id
FROM books b
JOIN authors a ON a.author_name = 'Robert C. Martin'
WHERE b.isbn = '9780132350884'
AND NOT EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.book_id = b.book_id AND ba.author_id = a.author_id
);

INSERT INTO book_authors (book_id, author_id)
SELECT b.book_id, a.author_id
FROM books b
JOIN authors a ON a.author_name = 'Thomas H. Cormen'
WHERE b.isbn = '9780262033848'
AND NOT EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.book_id = b.book_id AND ba.author_id = a.author_id
);

INSERT INTO book_authors (book_id, author_id)
SELECT b.book_id, a.author_id
FROM books b
JOIN authors a ON a.author_name = 'Abraham Silberschatz'
WHERE b.isbn = '9780073523323'
AND NOT EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.book_id = b.book_id AND ba.author_id = a.author_id
);

INSERT INTO book_authors (book_id, author_id)
SELECT b.book_id, a.author_id
FROM books b
JOIN authors a ON a.author_name = 'Stuart Russell'
WHERE b.isbn = '9780136042594'
AND NOT EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.book_id = b.book_id AND ba.author_id = a.author_id
);

-- 7. Physical book copies
INSERT INTO book_copies (book_id, accession_number)
SELECT book_id, 'DEMO-COPY-001' FROM books
WHERE isbn = '9780132350884'
AND NOT EXISTS (SELECT 1 FROM book_copies WHERE accession_number = 'DEMO-COPY-001');

INSERT INTO book_copies (book_id, accession_number)
SELECT book_id, 'DEMO-COPY-002' FROM books
WHERE isbn = '9780132350884'
AND NOT EXISTS (SELECT 1 FROM book_copies WHERE accession_number = 'DEMO-COPY-002');

INSERT INTO book_copies (book_id, accession_number)
SELECT book_id, 'DEMO-COPY-003' FROM books
WHERE isbn = '9780262033848'
AND NOT EXISTS (SELECT 1 FROM book_copies WHERE accession_number = 'DEMO-COPY-003');

INSERT INTO book_copies (book_id, accession_number)
SELECT book_id, 'DEMO-COPY-004' FROM books
WHERE isbn = '9780073523323'
AND NOT EXISTS (SELECT 1 FROM book_copies WHERE accession_number = 'DEMO-COPY-004');

INSERT INTO book_copies (book_id, accession_number)
SELECT book_id, 'DEMO-COPY-005' FROM books
WHERE isbn = '9780136042594'
AND NOT EXISTS (SELECT 1 FROM book_copies WHERE accession_number = 'DEMO-COPY-005');

-- 8. One returned borrowing
INSERT INTO borrowings
(copy_id, member_id, issued_by, returned_to,
 issue_date, due_date, return_date, active_copy_id)
SELECT bc.copy_id, m.member_id, librarian.user_id, librarian.user_id,
       '2026-11-01', '2026-11-15', '2026-11-10', NULL
FROM book_copies bc
JOIN members m ON m.student_id = 'DEMO-001'
JOIN users librarian ON librarian.email = 'librarian@library.test'
WHERE bc.accession_number = 'DEMO-COPY-004'
AND NOT EXISTS (
    SELECT 1 FROM borrowings br
    WHERE br.copy_id = bc.copy_id AND br.issue_date = '2026-11-01'
);

-- 9. One active borrowing
INSERT INTO borrowings
(copy_id, member_id, issued_by,
 issue_date, due_date, active_copy_id)
SELECT bc.copy_id, m.member_id, librarian.user_id,
       '2026-11-20', '2026-12-04', bc.copy_id
FROM book_copies bc
JOIN members m ON m.student_id = 'DEMO-002'
JOIN users librarian ON librarian.email = 'librarian@library.test'
WHERE bc.accession_number = 'DEMO-COPY-001'
AND NOT EXISTS (
    SELECT 1 FROM borrowings br
    WHERE br.copy_id = bc.copy_id AND br.issue_date = '2026-11-20'
);

COMMIT;