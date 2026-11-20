
-- =====================================================
-- Library Management System
-- Initial Database Schema
-- Database: MariaDB 10.11+
-- =====================================================

CREATE DATABASE IF NOT EXISTS library_management_system
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE library_management_system;

-- =====================================================
-- 1. USERS
-- Stores administrator, librarian, and member accounts.
-- =====================================================

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,

    role ENUM(
        'administrator',
        'librarian',
        'member'
    ) NOT NULL DEFAULT 'member',

    account_status ENUM(
        'active',
        'inactive',
        'suspended'
    ) NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================
-- 2. MEMBERS
-- Stores additional information about library members.
-- =====================================================

CREATE TABLE IF NOT EXISTS members (
    member_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    student_id VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(150),
    phone VARCHAR(30),
    joined_at DATE NOT NULL DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_members_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- 3. CATEGORIES
-- Stores book categories.
-- =====================================================

CREATE TABLE IF NOT EXISTS categories (
    category_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- =====================================================
-- 4. AUTHORS
-- Stores author information.
-- =====================================================

CREATE TABLE IF NOT EXISTS authors (
    author_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(150) NOT NULL,
    biography TEXT,

    INDEX idx_authors_name (author_name)
) ENGINE=InnoDB;

-- =====================================================
-- 5. BOOKS
-- Stores general information about books.
-- =====================================================

CREATE TABLE IF NOT EXISTS books (
    book_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id BIGINT UNSIGNED NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    publication_year SMALLINT UNSIGNED,
    description TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_books_title (title),
    INDEX idx_books_category (category_id),

    CONSTRAINT fk_books_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_books_publication_year
        CHECK (
            publication_year IS NULL
            OR publication_year BETWEEN 1000 AND 9999
        )
) ENGINE=InnoDB;

-- =====================================================
-- 6. BOOK_AUTHORS
-- Resolves the many-to-many relationship between
-- books and authors.
-- =====================================================

CREATE TABLE IF NOT EXISTS book_authors (
    book_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (book_id, author_id),

    INDEX idx_book_authors_author (author_id),

    CONSTRAINT fk_book_authors_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_book_authors_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================================
-- 7. BOOK_COPIES
-- Stores individual physical copies of books.
--
-- Borrowed status is derived from active borrowing
-- records rather than stored separately.
-- =====================================================

CREATE TABLE IF NOT EXISTS book_copies (
    copy_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    book_id BIGINT UNSIGNED NOT NULL,
    accession_number VARCHAR(50) NOT NULL UNIQUE,

    copy_status ENUM(
        'available',
        'lost',
        'damaged'
    ) NOT NULL DEFAULT 'available',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_book_copies_book (book_id),
    INDEX idx_book_copies_status (copy_status),

    CONSTRAINT fk_book_copies_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =====================================================
-- 8. BORROWINGS
-- Stores book issue and return transactions.
-- =====================================================

CREATE TABLE IF NOT EXISTS borrowings (
    borrowing_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    copy_id BIGINT UNSIGNED NOT NULL,
    member_id BIGINT UNSIGNED NOT NULL,
    issued_by BIGINT UNSIGNED NOT NULL,
    returned_to BIGINT UNSIGNED DEFAULT NULL,

    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Stores the copy ID while borrowing is active.
    -- Set to NULL when the book is returned.
    active_copy_id BIGINT UNSIGNED DEFAULT NULL,

    -- Prevents multiple active borrowings of one copy.
    UNIQUE KEY uq_borrowings_active_copy (active_copy_id),

    INDEX idx_borrowings_member (member_id, issue_date),
    INDEX idx_borrowings_due_date (due_date),
    INDEX idx_borrowings_copy (copy_id),

    CONSTRAINT fk_borrowings_copy
        FOREIGN KEY (copy_id)
        REFERENCES book_copies(copy_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_borrowings_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_borrowings_issued_by
        FOREIGN KEY (issued_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_borrowings_returned_to
        FOREIGN KEY (returned_to)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================================
-- END OF INITIAL DATABASE SCHEMA
-- =====================================================
