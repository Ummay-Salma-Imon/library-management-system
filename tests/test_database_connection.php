<?php

declare(strict_types=1);

require_once __DIR__ . '/../backend/config/connection.php';

try {
    $pdo = getDatabaseConnection();

    $statement = $pdo->query(
        'SELECT DATABASE() AS database_name, VERSION() AS server_version'
    );

    $databaseInfo = $statement->fetch();

    if (!$databaseInfo) {
        throw new RuntimeException('Could not retrieve database information.');
    }

    $tableStatement = $pdo->query(
        "SELECT COUNT(*) FROM information_schema.tables
         WHERE table_schema = DATABASE()
         AND table_type = 'BASE TABLE'"
    );

    $tableCount = (int) $tableStatement->fetchColumn();

    echo "Database connection: SUCCESS" . PHP_EOL;
    echo "Database: " . $databaseInfo['database_name'] . PHP_EOL;
    echo "Server version: " . $databaseInfo['server_version'] . PHP_EOL;
    echo "Tables detected: " . $tableCount . PHP_EOL;

    if ($tableCount !== 8) {
        throw new RuntimeException(
            "Expected 8 database tables, but found {$tableCount}."
        );
    }

    echo "Database structure verification: SUCCESS" . PHP_EOL;

} catch (Throwable $exception) {
    fwrite(
        STDERR,
        "Database connection test failed: " . $exception->getMessage() . PHP_EOL
    );

    exit(1);
}
