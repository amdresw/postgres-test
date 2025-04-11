CREATE DATABASE  techzone;

\c techzone;

CREATE TABLE Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Provider (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(20)
);

CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE Sale (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(id)
);

CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    stock INT NOT NULL,
    provider_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(id),
    FOREIGN KEY (provider_id) REFERENCES Provider(id)
);

CREATE TABLE SaleDetail (
    id SERIAL PRIMARY KEY,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES Sale(id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);
