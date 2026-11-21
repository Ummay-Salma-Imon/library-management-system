# Database Health Check API

## Overview

The health-check endpoint verifies whether the PHP backend can communicate with the MariaDB database.

## Endpoint

`GET /health.php`

File location: `backend/api/health.php`

## Successful Response

HTTP status: `200 OK`

```json
{
    "status": "ok",
    "database": "connected"
}
```

## Failed Response

HTTP status: `503 Service Unavailable`

```json
{
    "status": "error",
    "database": "unavailable"
}
```

## Implementation

1. Loads the reusable PDO connection.
2. Executes `SELECT 1` to verify database connectivity.
3. Returns a JSON response.
4. Uses HTTP 200 when the database is available.
5. Uses HTTP 503 when the connection fails.
6. Logs detailed errors on the server instead of exposing them in the API response.

## Response Headers

- Content-Type: `application/json; charset=utf-8`
- Cache-Control: `no-store`

## Testing

The endpoint was tested using the PHP built-in development server.

| Test | Expected result | Actual result |
|---|---|---|
| Valid database | HTTP 200 | PASS |
| Invalid database name | HTTP 503 | PASS |
| Successful JSON response | Database connected | PASS |
| Failed JSON response | Database unavailable | PASS |
| Internal error details in response | Not exposed | PASS |

Both tests completed successfully.
