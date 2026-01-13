all:
	docker compose up --build

down:
	docker compose down -v

re: down all
