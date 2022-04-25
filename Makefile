.PHONY: start-db stop-db restart-db migrateup migratedown

start-db:
	docker run -p 5432:5432 --name postgres -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=simple_bank -d postgres:12-alpine

stop-db:
	-docker stop postgres
	-docker rm postgres

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

restart-db: stop-db start-db