DROP DATABASE IF EXISTS `proyecto_login`;
CREATE DATABASE `proyecto_login`;
USE `proyecto_login`;

-- Tabla de usuarios (Punto a.ii)
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL
);

-- Tabla de estados (Punto a.iii y iv)
CREATE TABLE `user_status` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT,
    `status_text` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

-- Insertar usuario de prueba para el login
INSERT INTO `users` (`email`, `password`) VALUES ('alejandro@gmail.com', '123456');