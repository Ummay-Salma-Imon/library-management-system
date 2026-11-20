# System Architecture

## 1. Architecture Overview

The application will separate frontend presentation,
backend processing, and database storage.

## 2. Frontend Layer

The frontend is responsible for:
- Displaying application pages.
- Collecting user input.
- Performing basic browser-side validation.
- Sending HTTP requests to backend APIs.
- Displaying backend responses.

Technologies: HTML, CSS, JavaScript, Bootstrap.

## 3. Backend Layer

The backend is responsible for:
- Processing API requests.
- Authenticating users.
- Enforcing permissions.
- Validating incoming data.
- Applying application business rules.
- Communicating with the database.
- Returning JSON responses.

Technology: PHP.

## 4. Database Layer

The database stores:
- Users
- Books
- Categories
- Members
- Borrowing records

Technology: MariaDB / MySQL.

## 5. Request Flow

1. A user interacts with a frontend page.
2. JavaScript sends a request to a PHP API endpoint.
3. PHP validates the request.
4. The controller and service process the operation.
5. The model communicates with the database.
6. PHP returns a JSON response.
7. JavaScript updates the interface.

## 6. Separation of Responsibilities

HTML files will contain page structure.

CSS files will contain styling.

JavaScript files will contain frontend behavior.

PHP backend files will contain server-side processing.

SQL files will contain database definitions and scripts.
