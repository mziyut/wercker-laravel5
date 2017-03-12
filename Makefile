
build:
	docker build -t mziyut/wercker-laravel5:0.1.2 .

push:
	docker push mziyut/wercker-laravel5

run:
	docker run mziyut/wercker-laravel5:latest

