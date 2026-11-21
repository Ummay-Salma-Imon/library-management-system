# PHP Database Connection Layer

## Overview

The project uses PHP Data Objects (PDO) to connect the PHP backend to MariaDB.

The database configuration and connection logic are separated so that other backend components can reuse the same connection.

## File Structure

- `backend/config/database.php` - Reads and validates database environment variables.
- `backend/config/connection.php` - Creates and reuses the PDO connection.
- `tests/test_database_connection.php` - Verifies database connectivity and table structure.

## Database Configuration

The application reads these environment variables:

| Variable | Purpose |
|---|---|
| DB_HOST | Database server hostname |
| DB_PORT | Database server port |
| DB_NAME | Database name |
| DB_USER | Database username |
| DB_PASSWORD | Database password (optional) |

Credentials are not hardcoded into the PHP source files.

## PDO Connection Settings

The reusable `getDatabaseConnection()` function uses:

- PDO with the MySQL driver.
- `utf8mb4` character encoding.
- Exception mode for database errors.
- Associative arrays as the default fetch mode.
- Native prepared statements.
- A static connection variable to reuse the connection during the request.

## Connection Test

The connection test verifies:

1. Successful PDO connection.
2. Selected database name.
3. MariaDB server version.
4. Number of database tables.

Eight tables are expected.

## Verified Test Results

| Item | Result |
|---|---|
| PHP version | 8.5.12 |
| MariaDB version | 10.11.16 |
| Database | library_management_system |
| Database connection | PASS |
| Table count | 8 of 8 |
| Structure verification | PASS |

The test completed successfully.

## Security Notes

- Database credentials must not be committed to Git.
- Environment variables supply connection settings.
- Detailed database errors must not be exposed through public API responses.
