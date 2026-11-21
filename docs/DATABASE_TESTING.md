# Database Testing Report

## 1. Overview

The initial database implementation was tested using MariaDB 10.11.16.

The tests covered sample data insertion, duplicate prevention,
foreign-key enforcement, and record verification.

## 2. Sample Data

The demonstration dataset contains:

| Table | Records |
|---|---:|
| users | 4 |
| members | 2 |
| categories | 4 |
| authors | 4 |
| books | 4 |
| book_authors | 4 |
| book_copies | 5 |
| borrowings | 2 |

The dataset includes administrator, librarian, and member accounts,
four book records, five physical copies, one returned borrowing,
and one active borrowing.

## 3. Test Results

### Test 1: Sample Data Idempotency

**Result: PASSED**

The seed SQL script was executed a second time.
No duplicate demonstration records were created.

### Test 2: Duplicate Active Borrowing Prevention

**Result: PASSED**

A second active borrowing was attempted for a physical copy
that already had an active borrowing.

MariaDB rejected the operation with error 1062 because of
the unique constraint `uq_borrowings_active_copy`.

### Test 3: Foreign-Key Enforcement

**Result: PASSED**

A borrowing record was attempted using a nonexistent physical
book copy.

MariaDB rejected the operation with error 1452 because of
the foreign-key constraint `fk_borrowings_copy`.

### Test 4: Final Record Verification

**Result: PASSED**

All expected demonstration record counts remained unchanged
after the tests.

## 4. Conclusion

The initial sample dataset was inserted successfully.
The database prevented duplicate active borrowings and rejected
a borrowing that referenced a nonexistent physical copy.

These tests confirm the expected behavior of the tested
unique and foreign-key constraints.

## 5. Remaining Work

- Implement the PHP database connection.
- Add application-level borrowing and return validation.
- Test database transactions through the PHP backend.
- Develop API endpoints for library operations.
