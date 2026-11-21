<?php

declare(strict_types=1);

$requiredVariables = [
    'DB_HOST',
    'DB_PORT',
    'DB_NAME',
    'DB_USER'
];

foreach ($requiredVariables as $variable) {
    if (getenv($variable) === false || getenv($variable) === '') {
        throw new RuntimeException(
            "Required database environment variable is missing: {$variable}"
        );
    }
}

return [
    'host' => getenv('DB_HOST'),
    'port' => getenv('DB_PORT'),
    'database' => getenv('DB_NAME'),
    'username' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD') ?: '',
];
