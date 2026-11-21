# Development Log

## 2026-11-20 - Project Initialization

### Completed
- Created the GitHub repository.
- Cloned the repository to the development computer.
- Configured repository-specific Git identity for Ummay.
- Configured separate SSH authentication for Ummay's GitHub account.
- Verified PHP 8.5.12 through XAMPP.
- Verified MariaDB 10.11.16 through XAMPP.
- Verified PDO, pdo_mysql, mysqli, mbstring, and openssl extensions.
- Confirmed Apache and MariaDB services are working.
- Prepared the initial project architecture and requirements.

### Current Status
Project initialization and requirements planning.

### Next Tasks
- Review the initial folder structure.
- Finalize the application requirements.
- Design the database entities and relationships.
- Plan the frontend and backend implementation.

## 2026-11-20 - Database Design

### Completed
- Identified the initial database entities.
- Separated user accounts from member profiles.
- Separated general book information from physical copies.
- Designed the many-to-many relationship between books and authors.
- Documented database relationships and integrity rules.
- Prepared the initial ER diagram.

### Current Status
Initial logical database design prepared for review.

### Next Tasks
- Review and finalize database relationships.
- Implement the SQL schema.
- Create the database in the local MariaDB server.
- Verify tables, keys, indexes, and constraints.

## 2026-11-20 - Initial Database Implementation

### Completed
- Created the initial MariaDB database schema.
- Created eight relational database tables.
- Added primary keys and foreign keys.
- Added unique constraints and indexes.
- Established relationships between the database entities.
- Added a unique constraint to prevent multiple active borrowings
  of the same physical book copy.
- Verified that all eight tables use the InnoDB storage engine.
- Verified the foreign-key relationships through phpMyAdmin.

### Current Status
Initial database schema implemented and verified successfully.

### Next Tasks
- Review the database structure.
- Insert controlled sample records.
- Test relationships and database constraints.
- Configure the PHP database connection.

## 2026-11-21 - Sample Data and Database Testing

### Completed
- Created a repeatable SQL sample data script.
- Added demonstration users and member profiles.
- Added book categories, authors, books, and physical copies.
- Added one returned and one active borrowing record.
- Verified sample data insertion and repeated execution.
- Confirmed duplicate active borrowing prevention.
- Confirmed foreign-key enforcement for nonexistent book copies.
- Verified all expected demonstration record counts.
- Created the database testing report.

### Current Status
Sample data insertion and the tested database integrity rules
passed successfully.

### Next Tasks
- Implement the PHP database connection layer.
- Test PHP connectivity with MariaDB.
- Build and verify the first database health-check API.