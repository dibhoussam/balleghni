<?php

return [
    'users' => [
        'base_uri' => env('KEYCLOAK_API_BASE_URI'),
        'secret' => env('KEYCLOAK_API_CLIENT_SECRET'),
    ],

    'stats' => [
        'base_uri' => env('SUPERSET_API_BASE_URI'),
        'secret' => env('SUPERSET_API_SECRET'),
    ],

    'images' => [
        'base_uri' => env('IMAGES_API_BASE_URI'),
        'secret' => env('IMAGES_API_SECRET'),
    ],
];