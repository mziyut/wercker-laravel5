# wercker-laravel5

## sample

```
box: mziyut/wercker-laravel5

build:
  services:
    - id: mysql
      tag: latest
      env:
        MYSQL_ROOT_PASSWORD: foo
        MYSQL_DATABASE: bar
        MYSQL_USER: foobar
        MYSQL_PASSWORD: hoge
  steps:
    - script:
      name: Print enviromemt
      code: |
        env
    - script:
      name: Install dependencies - composer
      code: |
         php composer.phar install
    - script:
      name: Create env file
      code: |-
         cp .env.wercker .env
    - script:
      name: Replace database host
      code: |-
         sed -i "s/__REPLACE_DATABASE_HOST__/${MYSQL_PORT_3306_TCP_ADDR}/g" .env
    - script:
      name: Generate application key
      code: |-
         php artisan key:generate
    - script:
      name: Run migration
      code: |-
         php artisan migrate
    - script:
      name: Run seed
      code: |-
         php artisan db:seed
    - script:
      name: install frontend global depengency
      code: |-
        npm -g install bower gulp
    - script:
      name: install frontend depengency (bower)
      code: |-
         npm install
    - script:
      name: frontend build test
      code: |-
        cd src gulp --production
    - script:
      name: Run phpunit
      code: |-
         phpunit
```
