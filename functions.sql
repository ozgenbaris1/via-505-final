create function fn_get_closest_courier(customer_id int) returns int deterministic
    begin
        declare courier int;
        
        with customer_location as (
            select
                a.latitude,
                a.longitude
            from customer c
            inner join address a using(address_id)
            where c.customer_id = customer_id
        ),
            
        closest_courier as (
            select
                c.courier_id,
                sqrt(power(cl.latitude - c.latitude, 2) + power(cl.longitude - c.longitude, 2)) as distance
            from customer_location cl
            join courier c
            order by distance asc
            limit 1
        )

        select courier_id into courier
        from closest_courier cc;

        return courier;
        end
;

create function fn_get_closest_store(customer_id int) returns int deterministic
    begin
        declare store int;
        
        with customer_location as (
            select
                a.latitude,
                a.longitude
            from customer c
            inner join address a using(address_id)
            where c.customer_id = customer_id
        ),
            
        store_locations as (
            select
                s.store_id,
                a.latitude,
                a.longitude
            from store s
            inner join address a using(address_id)
        ),
                        
        closest_store as (
            select
                sl.store_id,
                sqrt(power(cl.latitude - sl.latitude, 2) + power(cl.longitude - sl.longitude, 2)) as distance
            from customer_location cl
            join store_locations sl
            order  by distance asc
            limit 1
        )
        
        select store_id into store
        from closest_store cs;

        return store;
        end
;