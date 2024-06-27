all :
	cd srcs && docker-compose up --build

force :
	cd srcs && docker-compose down
	docker volume rm srcs_wordpress
	docker volume rm srcs_mariadb
	cd srcs && docker-compose up --build

clean :
	cd srcs/cache/wordpress && sudo rm -rf *
	cd srcs/cache/mariadb && sudo rm -rf *
re : clean force
