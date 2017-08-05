
build:
	docker build -t mziyut/wercker-laravel5:0.2 .

push:
	docker push mziyut/wercker-laravel5

run:
	docker run mziyut/wercker-laravel5:latest -it bash

