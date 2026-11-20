# Technical Decisions

## 1. Frontend

HTML5 will define page structures.

CSS3 will handle all styling.

JavaScript will handle browser-side interactions and API
communication.

Bootstrap 5 will provide responsive UI components where useful.

## 2. Backend

PHP will be used to implement backend functionality and APIs.

The backend will return JSON responses to frontend requests.

Backend business logic will be separated from database access.

## 3. Database

MariaDB, using MySQL-compatible SQL, will store application data.

PDO will be the preferred PHP database access interface.

Prepared statements will be used for database queries.

## 4. Architecture

The project will use a separated frontend and backend
architecture.

Frontend:
- HTML pages
- CSS stylesheets
- JavaScript files

Backend:
- API endpoints
- Controllers
- Models
- Services
- Middleware
- Database configuration

## 5. Development Environment

- Operating System: Windows
- Local server: XAMPP Apache
- Database server: XAMPP MariaDB
- Editor: Visual Studio Code
- Version control: Git and GitHub

## 6. Security Principles

- Password hashing using PHP password_hash().
- Password verification using password_verify().
- Prepared statements for database queries.
- Server-side input validation.
- Session-based authentication where appropriate.
- Role-based access control.
- Secrets must not be committed to GitHub.

## 7. Decision Status

These are the initial technical decisions. They may be refined
when implementation and testing reveal additional requirements.
