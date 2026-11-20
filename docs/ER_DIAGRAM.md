# Entity Relationship Diagram

The following diagram represents the initial logical
database design.

```mermaid
erDiagram
    USERS ||--o| MEMBERS : has
    USERS ||--o{ BORROWINGS : issues
    USERS o|--o{ BORROWINGS : receives

    CATEGORIES ||--o{ BOOKS : contains

    BOOKS ||--o{ BOOK_AUTHORS : has
    AUTHORS ||--o{ BOOK_AUTHORS : writes

    BOOKS ||--o{ BOOK_COPIES : contains

    MEMBERS ||--o{ BORROWINGS : makes
    BOOK_COPIES ||--o{ BORROWINGS : appears_in

    USERS {
        int user_id PK
        varchar full_name
        varchar email UK
        varchar password_hash
        enum role
        enum account_status
        timestamp created_at
        timestamp updated_at
    }

    MEMBERS {
        int member_id PK
        int user_id FK
        varchar student_id UK
        varchar department
        varchar phone
        date joined_at
    }

    CATEGORIES {
        int category_id PK
        varchar category_name UK
        text description
    }

    AUTHORS {
        int author_id PK
        varchar author_name
        text biography
    }

    BOOKS {
        int book_id PK
        int category_id FK
        varchar isbn UK
        varchar title
        varchar publisher
        smallint publication_year
        text description
    }

    BOOK_AUTHORS {
        int book_id PK, FK
        int author_id PK, FK
    }

    BOOK_COPIES {
        int copy_id PK
        int book_id FK
        varchar accession_number UK
        enum copy_status
    }

    BORROWINGS {
        int borrowing_id PK
        int copy_id FK
        int member_id FK
        int issued_by FK
        int returned_to FK
        date issue_date
        date due_date
        date return_date
    }
```

## Notes

- PK means Primary Key.
- FK means Foreign Key.
- UK means Unique Key.
- A book can have multiple physical copies.
- A book can have multiple authors.
- A member can borrow different copies over time.
- A physical copy can have only one active borrowing.

This is the initial logical model. The final SQL schema
will define data types, indexes, constraints, and deletion
rules explicitly.
