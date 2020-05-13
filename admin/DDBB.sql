CREATE DATABASE therockproject;

USE therockproject;

CREATE TABLE users (

  id            int(100) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username      varchar(25) NOT NULL,
  email         varchar(50) NOT NULL,
  pass          varchar(50) NOT NULL,
  saldo         double(5,2) NOT NULL,
  suscripcion   varchar(20) NOT NULL,
  phpmyadmin    varchar(250) NOT NULL,
  url           varchar(250) NOT NULL,
  mysql_user    varchar(25) NOT NULL
)ENGINE=InnoDB;