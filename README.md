# wercker-laravel5

Laravel5 testing box for wercker

# wercker.yml example

```
box: suttang/wercker-laravel5
services:
  - id: mysql
    env:
      MYSQL_ROOT_PASSWORD: rootpasswd
      MYSQL_USER: testuser
      MYSQL_PASSWORD: testpasswd
      MYSQL_DATABASE: testdb

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

    - create-file:
        name: Edit phpunit.xml
        filename: phpunit.xml
        overwrite: true
        content: |-
          <?xml version="1.0" encoding="UTF-8"?>
          <phpunit backupGlobals="false"
                   backupStaticAttributes="false"
                   bootstrap="bootstrap/autoload.php"
                   colors="true"
                   convertErrorsToExceptions="true"
                   convertNoticesToExceptions="true"
                   convertWarningsToExceptions="true"
                   processIsolation="false"
                   stopOnFailure="false"
                   verbose="true"
                   testdox="true">
              <testsuites>
                  <testsuite name="Application Test Suite">
                      <directory>./tests/</directory>
                  </testsuite>
              </testsuites>
              <filter>
                  <whitelist>
                      <directory suffix=".php">app/</directory>
                  </whitelist>
              </filter>
              <php>
                  <env name="APP_ENV" value="testing"/>
                  <env name="CACHE_DRIVER" value="array"/>
                  <env name="SESSION_DRIVER" value="array"/>
                  <env name="QUEUE_DRIVER" value="sync"/>
                  <env name="DB_HOST" value="$MYSQL_PORT_3306_TCP_ADDR"/>
                  <env name="DB_DATABASE" value="testdb"/>
                  <env name="DB_USERNAME" value="testuser"/>
                  <env name="DB_PASSWORD" value="testpasswd"/>
                  <env name="DB_PORT" value="$MYSQL_PORT_3306_TCP_PORT"/>
              </php>
          </phpunit>

    - script:
        name: Run phpunit
        code: |-
          phpunit

```
