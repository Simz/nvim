#!/bin/bash
docker exec -u www-data grt-site-web-v14-php-fpm-1 ./vendor/bin/typo3 fluid:analyze "$@"
