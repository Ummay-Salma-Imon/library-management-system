<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/connection.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

try {
    $pdo = getDatabaseConnection();

    $pdo->query('SELECT 1');

    http_response_code(200);

    echo json_encode([
        'status' => 'ok',
        'database' => 'connected'
    ], JSON_UNESCAPED_SLASHES);

} catch (Throwable $exception) {
    error_log('Database health check failed: ' . $exception->getMessage());

    http_response_code(503);

    echo json_encode([
        'status' => 'error',
        'database' => 'unavailable'
    ], JSON_UNESCAPED_SLASHES);
}
