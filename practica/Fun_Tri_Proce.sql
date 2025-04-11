-- creacion de la funcion

CREATE OR REPLACE FUNCTION fn_register_audit()
RETURNS TRIGGER AS $$
DECLARE
  total NUMERIC;
BEGIN

	total= (select sum(quantity*price) from order_details where id=new.id);
	
	insert into sales_audit(order_id,user_id,total_value) values(
		new.order_id,
		(select distinct user_id from orders where new.order_id=id),
	 	total			
	);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- creacion del trigger

CREATE TRIGGER trg_audit_sale
AFTER INSERT ON order_details	
FOR EACH ROW
EXECUTE FUNCTION fn_register_audit();

-- insercion de prueba

INSERT INTO order_details ("order_id", "product_id", "quantity", "price")
VALUES (9, 4, 5, 1432.67);


-- creacion de la vista 

create view historial_ventas as
select sa.audit_id,u.first_name||' '||u.last_name as username,sa.total_value,sa.audit_date from sales_audit sa inner join users u on sa.user_id = u.id;

select * from historial_ventas;

-- creacion de la vista materializada

create materialized view ingresos_diarios as
select date(audit_date), sum(total_value) from sales_audit where date(audit_date)=current_date group by 1;
refresh materialized view ingresos_diarios;

select * from ingresos_diarios;

-- procedimiento 

--Crea un procedimiento llamado prc_register_sale que permita recibir los valores de user_id, product_id y quantity:


CREATE OR REPLACE PROCEDURE prc_register_sale(
  p_user_id varchar(50),
  p_product_id INT,
  p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
	stock_actual integer;
  	nuevo_stock integer;
  	new_id_order integer;
  	price_product numeric(10,2);
BEGIN
	-- Verificar stock
	SELECT stock INTO stock_actual FROM products WHERE id = p_product_id;
	
	IF stock_actual < p_quantity THEN
		RAISE EXCEPTION 'Stock insuficiente';
	END IF;
	
	-- 1. Registrar orden
	insert into orders ("orderdate", "user_id")
	VALUES (current_date, p_user_id)
	returning id into new_id_order;
	
	-- 2. Registrar detalle
	
	select price into price_product from products where id= p_product_id;
	  
	INSERT INTO order_details ("order_id", "product_id", "quantity", "price")
	VALUES (new_id_order, p_product_id, p_quantity,price_product);
	
	-- 3. Actualizar stock
	nuevo_stock=stock_actual-p_quantity;
	update products set stock=nuevo_stock where id=p_product_id;
END;
$$;

call prc_register_sale('00001',12,60);

-- vista de productos con stock menor a 10 

CREATE VIEW vw_products_low_stock AS
SELECT id, name, stock
FROM products
WHERE stock < 10;

select * from vw_products_low_stock;


-- FUNCTION para registrar actualizaciones de la tabla orders teniendo presente la siguiente instrucción SQL y las sugerencias.

CREATE OR REPLACE FUNCTION fn_log_order_update()
RETURNS TRIGGER AS $$
BEGIN
	insert into orders_update_log(order_id,old_user_id,new_user_id,old_order_date,new_order_date) values(
		new.id,
		old.user_id,
		new.user_id,
		old.orderdate,
		new.orderdate
	);
	
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_order_update
AFTER UPDATE ON orders
FOR EACH ROW
-- Cuando la fecha de la orden o el usuario cambie.
-- Usa WHEN, OLD y NEW.
when (old.user_id<>new.user_id or old.orderdate<>new.orderdate)
EXECUTE FUNCTION fn_log_order_update();

update orders set orderdate = current_date where id=1;



-- FUNCTION para evitar eliminación si el pedido ya tiene detalles teniendo presente la siguiente instrucción SQL y las sugerencias.

CREATE OR REPLACE FUNCTION fn_prevent_order_delete()
RETURNS TRIGGER AS $$
DECLARE
  exists_detail BOOLEAN;
  cantidad integer;
BEGIN
	select count(*) into cantidad from orders o inner join order_details od on o.id=od.order_id where od.order_id=15;

	if cantidad>0 then
		exists_detail:=true;
	else
		exists_detail:=false;
	end if;

  IF exists_detail THEN
    RAISE NOTICE 'Error: El pedido ya tiene detalles';
  END IF;

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;


create or replace trigger trg_prevent_order_delete
before delete on orders
for each row
execute function fn_prevent_order_delete();

delete from orders where id=1;


select count(*) from orders o inner join order_details od on o.id=od.order_id where od.order_id=15;

create or replace procedure prc_update_order_user(
	p_order_id INT,
	p_new_user_id varchar(50)
)
LANGUAGE plpgsql
as $$
begin 

	update orders set user_id=p_new_user_id where id =p_order_id;
	
end;
$$

call prc_update_order_user(5,'00008');

create or replace procedure prc_update_order_user(
	p_order_date DATE,
	p_order_id INT
)
language plpgsql
as $$
begin 
	update orders set orderdate=p_order_date where id =p_order_id;
end;
$$

call prc_update_order_user(current_date,5);