# Software Requirements Specification

## 1. Project Introduction

The Library Management System is a web application intended
to support common library operations through a centralized
system.

## 2. User Roles

### Administrator
- Manage librarian accounts.
- View system information.
- Monitor library operations.

### Librarian
- Manage books and categories.
- Register and manage members.
- Issue and receive returned books.
- Monitor overdue borrowings.

### Student / Library Member
- Browse available books.
- Search for books.
- View borrowing history.
- Check borrowing due dates and status.

## 3. Functional Requirements

- FR-01: Users can log in securely.
- FR-02: Authorized staff can add, update, and remove books.
- FR-03: Staff can manage book categories.
- FR-04: Staff can register and manage library members.
- FR-05: Staff can issue books to members.
- FR-06: Staff can record returned books.
- FR-07: Users can view book availability.
- FR-08: Users can search for books.
- FR-09: Members can view their borrowing history.
- FR-10: Staff can identify overdue borrowings.

## 4. Non-Functional Requirements

- NFR-01: The interface should be easy to understand.
- NFR-02: The application should support desktop and mobile screens.
- NFR-03: Passwords must be securely hashed.
- NFR-04: Database operations must use secure queries.
- NFR-05: Access must be restricted according to user roles.
- NFR-06: The system should maintain consistent borrowing records.

## 5. Initial Project Scope

The first development version will focus on authentication,
book management, member management, and borrowing operations.

Additional features will be considered after the essential
features are implemented and tested.
