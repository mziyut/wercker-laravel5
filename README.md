# wercker-laravel5

Laravel5 testing box for wercker

# wercker.yml example

```
box: ryanwinchester/wercker-laravel5

build:
  steps:
    - script:
        name: Install dependencies
        code: |
          composer install

    - script:
        name: Create env file
        code: |-
          cp .env.example .env

    - script:
        name: Generate application key
        code: |-
          php artisan key:generate

    - script:
        name: Run phpunit
        code: |-
          phpunit

```
