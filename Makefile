all : cache
	cd srcs && docker-compose up --build

force : cache
	cd srcs && docker-compose down
	docker volume rm srcs_wordpress
	docker volume rm srcs_mariadb
	cd srcs && docker-compose up --build

clean :
	cd srcs/cache/wordpress && sudo rm -rf *
	cd srcs/cache/mariadb && sudo rm -rf *

cache :
	mkdir -p srcs/cache
	mkdir -p srcs/cache/wordpress
	mkdir -p srcs/cache/mariadb

re : clean force
