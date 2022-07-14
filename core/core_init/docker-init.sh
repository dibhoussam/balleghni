#!/bin/bash

while !</dev/tcp/core_db/3306; do sleep 1; done; \
php artisan migrate