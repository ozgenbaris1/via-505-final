create procedure sp_get_inventory_of_store(store_id int)
	select s.name, i.quantity, p.name
	from store s
	left join inventory i using(store_id)
	inner join product p using(product_id)
	where s.store_id = store_id
;

/*
	can be called as follows:
	    call sp_make_order('[{"product_id": 1, "quantity": 3}, {"product_id":2, "quantity":1}]', 1)
*/
create procedure sp_make_order(j json, customer_id int)

    begin
		/* get courier_id of closest courier to the customer*/
        select fn_get_closest_courier(customer_id) into @courier_id;

		/* get store_id of closest store to the customer*/
        select fn_get_closest_store(customer_id) into @store_id;

		/* write order to customer_order table */
        insert into
            customer_order (customer_id, status_id, courier_id, store_id)
        value
            (customer_id, 1, @courier_id, @store_id);

		/* get auto-generated customer_order_id from customer_order table */
        select last_insert_id() into @customer_order_id;

		/* parse and write json input to a temporary table */
        create temporary table order_detail
            with parsed as (
                select jt.product_id, jt.quantity
                from json_table(
                    j, '$[*]'
                    columns (
                        product_id int path '$.product_id',
                        quantity int path '$.quantity'
                    )
                ) jt
            )
            select quantity, product_id
            from parsed
        ;

		/* write product and quantity details of the order to the customer_order_detail table */
        insert into
            customer_order_detail(customer_order_id, quantity, product_id)
            select @customer_order_id, quantity, product_id
            from order_detail
        ;

		/* update stocks */
        update inventory i
        inner join order_detail od using(product_id)
        set i.quantity = i.quantity - od.quantity
        where i.store_id = @store_id
        ;

    end
;

create procedure sp_confirm_delivery(customer_order_id int)
	update customer_order co
	set co.status_id = 4
	where co.customer_order_id = customer_order_id
;


create procedure sp_give_rating(point int, customer_order_id int)
    insert into 
		rating(point, customer_id, customer_order_id, courier_id)
        select
            point,
            co.customer_order_id,
            co.customer_id,
            co.courier_id
        from customer_order co
        where co.customer_order_id = customer_order_id
;
