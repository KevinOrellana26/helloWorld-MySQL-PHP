CREATE DATABASE mydb;
CREATE USER 'user'@'%' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES on mydb.* TO 'user'@'%';
FLUSH PRIVILEGES;

USE mydb;

CREATE TABLE helloWorld (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensaje VARCHAR(100)
);

INSERT INTO helloWorld (mensaje) VALUES ('Hello World');