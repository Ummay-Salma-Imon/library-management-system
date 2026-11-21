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
## November 21, 2026 - PHP PDO Database Connection

Implemented the initial PHP database connection layer.

Work completed:
- Added environment-based configuration in `backend/config/database.php`.
- Added reusable PDO connection logic in `backend/config/connection.php`.
- Configured utf8mb4, exception handling, associative fetch mode, and native prepared statements.
- Added `tests/test_database_connection.php`.
- Added `docs/PHP_DATABASE_CONNECTION.md`.

Verification:
- All three PHP files passed syntax checks.
- PDO successfully connected to the local MariaDB server.
- Database selected: `library_management_system`.
- MariaDB version: 10.11.16.
- All eight expected tables were detected.

Result: PHP database connection test passed.

## November 21, 2026 - Database Health Check API

Implemented the initial database health-check endpoint.

Work completed:
- Added `backend/api/health.php`.
- Implemented a database connectivity check using the reusable PDO connection.
- Added JSON responses and appropriate HTTP status codes.
- Added generic error responses to avoid exposing database details publicly.
- Added server-side error logging.
- Documented the endpoint in `docs/HEALTH_CHECK_API.md`.

Verification:
- PHP syntax check passed.
- Valid database connection returned HTTP 200.
- Invalid database name returned HTTP 503.
- Both JSON response bodies matched expectations.
- Internal database errors were not exposed in the API response.

Result: Both health-check tests passed.
