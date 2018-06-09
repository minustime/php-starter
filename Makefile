all: info

info:
	@echo 'Usage: make <build|up|down|rm>'
build:
	docker-compose -f docker-compose.yml build 
up:
	docker-compose -f docker-compose.yml up -d
down:
	docker-compose -f docker-compose.yml down 
rm:
	docker-compose -f docker-compose.yml rm
exec:
	docker-compose -f docker-compose.yml exec server bash
