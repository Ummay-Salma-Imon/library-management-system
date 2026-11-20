# Database Design

## 1. Overview

The Library Management System will use a relational database
with MariaDB and MySQL-compatible SQL.

The initial database name will be:

library_management_system

## 2. Database Tables

### 2.1 users

Stores accounts that can log in to the application.

Main fields:
- user_id: Primary key.
- full_name: User's full name.
- email: Unique login email.
- password_hash: Securely hashed password.
- role: Administrator, librarian, or member.
- account_status: Active or inactive.
- created_at: Account creation timestamp.
- updated_at: Last update timestamp.

### 2.2 members

Stores library membership information.

Main fields:
- member_id: Primary key.
- user_id: Foreign key referencing users.
- student_id: Unique student or membership identifier.
- department: Academic department.
- phone: Contact number.
- joined_at: Membership registration date.

A member must have a user account. Administrator and
librarian accounts do not require member profiles.

### 2.3 categories

Stores book categories.

Main fields:
- category_id: Primary key.
- category_name: Unique category name.
- description: Optional category description.

### 2.4 authors

Stores author information.

Main fields:
- author_id: Primary key.
- author_name: Author's name.
- biography: Optional biography.

### 2.5 books

Stores general information about books.

Main fields:
- book_id: Primary key.
- category_id: Foreign key referencing categories.
- isbn: Unique ISBN when provided.
- title: Book title.
- publisher: Publisher name.
- publication_year: Publication year.
- description: Optional book description.
- created_at: Record creation timestamp.
- updated_at: Last update timestamp.

### 2.6 book_authors

Connects books and authors.

Main fields:
- book_id: Foreign key referencing books.
- author_id: Foreign key referencing authors.

The combination of book_id and author_id will be the
composite primary key.

### 2.7 book_copies

Stores individual physical copies of books.

Main fields:
- copy_id: Primary key.
- book_id: Foreign key referencing books.
- accession_number: Unique library copy identifier.
- copy_status: Available, lost, or damaged.
- Borrowed status is derived from active borrowing records.
- created_at: Record creation timestamp.

One book can have multiple physical copies.

### 2.8 borrowings

Stores book issue and return transactions.

Main fields:
- borrowing_id: Primary key.
- copy_id: Foreign key referencing book_copies.
- member_id: Foreign key referencing members.
- issued_by: Foreign key referencing users.
- returned_to: Optional foreign key referencing users.
- issue_date: Date the book was issued.
- due_date: Expected return date.
- return_date: Actual return date, if returned.

An active borrowing has no return_date.

Overdue status will be calculated using due_date and
return_date rather than stored as a separate status.

## 3. Relationships

- One user can have one member profile.
- One category can contain many books.
- One book can have multiple authors.
- One author can be associated with multiple books.
- One book can have multiple physical copies.
- One member can have multiple borrowing records.
- A physical copy can have multiple borrowing records over time.
- Only one active borrowing is allowed per physical copy at a time.
- Borrowed availability is determined from active borrowing records.
- A librarian or administrator can issue and receive books.

## 4. Database Integrity Rules

- Every table must have an appropriate primary key.
- Foreign keys must reference valid records.
- Email addresses must be unique.
- Student/member identifiers must be unique.
- Accession numbers must be unique.
- A book copy cannot be issued when it is unavailable.
- A physical copy cannot have multiple active borrowings.
- A returned book must have a return date.
- A due date cannot be earlier than the issue date.

## 5. Normalization

The design separates users, membership profiles, books,
authors, categories, copies, and borrowing transactions.

The book_authors table resolves the many-to-many relationship
between books and authors.

Individual copies are stored separately from book details
to prevent repeating general book information.

These decisions aim to reduce unnecessary duplication and
maintain consistent records.

## 6. Initial Scope

This database design covers the essential library operations.

Reservations, fines, notifications, and advanced reporting
may be considered in later development stages.

## 7. Design Status

Initial database schema implemented and verified successfully.

## Implementation clarification - 2026-11-20

The following details describe the implemented database structure and
supersede any earlier conflicting descriptions in this document.

### Physical Book Copy Status

The `book_copies.copy_status` column supports these values:

- `available`
- `lost`
- `damaged`

Borrowed status is derived from active borrowing records. It is not stored
as a separate value in `copy_status`.

### Active Borrowing Protection

The `borrowings.active_copy_id` column stores the physical copy ID while
a borrowing is active. It must be set to `NULL` when the book is returned.

A unique constraint on `active_copy_id` prevents multiple active borrowing
records from using the same physical book copy.

The PHP borrowing and return operations must update this column correctly
within database transactions. Application-level validation must also check
borrowing dates and return information before database changes are committed.
