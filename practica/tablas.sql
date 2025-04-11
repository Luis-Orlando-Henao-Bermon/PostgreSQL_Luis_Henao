-- CREAR TABLE DE usuarios
CREATE TABLE users (
	id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    last_connection INET NOT NULL,
    website VARCHAR(100) NOT NULL
);

-- CREACION DE TABLA products
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    stock SMALLINT DEFAULT 0,
    price NUMERIC(10,2) NOT NULL,
    stockmin SMALLINT DEFAULT 0,
    stockmax SMALLINT DEFAULT 0
);


-- CREACION DE TABLAS orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    orderdate DATE NOT NULL,
    user_id VARCHAR(50) NOT NULL
);


-- CREACION DE TABLA order_details
CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL, 
    product_id INTEGER NOT NULL,
    quantity SMALLINT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id);
ALTER TABLE order_details ADD CONSTRAINT fk_order_details FOREIGN KEY(order_id) REFERENCES orders(id);
ALTER TABLE order_details ADD CONSTRAINT fk_product FOREIGN KEY(product_id) REFERENCES products(id);

CREATE TABLE sales_audit (
  audit_id SERIAL PRIMARY KEY,
  order_id INT,
  user_id VARCHAR(50),
  total_value NUMERIC,
  audit_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE orders_update_log (
  log_id SERIAL PRIMARY KEY,
  order_id INT,
  old_user_id varchar(50),
  new_user_id varchar(50),
  old_order_date DATE,
  new_order_date DATE,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from sales_audit;

select * from orders;

select * from products order by id;

select * from order_details order by 2;

select * from orders_update_log;