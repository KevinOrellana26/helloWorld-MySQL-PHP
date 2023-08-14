#!/bin/bash

# Iniciar el servicio MySQL
service mysql start

# Esperar hasta que MySQL esté completamente iniciado
while ! mysqladmin ping -hlocalhost -uroot -ppassword --silent; do
    sleep 1
done

# Crear la base de datos, la tabla y el usuario 
mysql -uroot -ppassword <<EOF
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES on $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;

USE $MYSQL_DATABASE;

CREATE TABLE $TABLE_NAME (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensaje VARCHAR(100)
);

INSERT INTO $TABLE_NAME (mensaje) VALUES ('Hello World');
EOF

tail -f /dev/null