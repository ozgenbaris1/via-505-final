import mysql.connector

data_dir = "/home/barisozgen/development/personal/via/via-505/via-505-final/data"
tables = [
    "country",
    "city",
    "district",
    "address",
    "customer",
    "category",
    "product",
    "status",
    "store",
    "inventory",
    "stock_entry",
    "stock_entry_detail",
    "courier",
    "customer_order",
    "customer_order_detail",
    "rating",
]


with mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="gotur",
    allow_local_infile=True,
) as conn:

    with conn.cursor() as cur:
        for table in tables:
            query = f"LOAD DATA LOCAL INFILE '{data_dir}/{table}.csv' INTO TABLE {table} fields terminated by ',' ENCLOSED BY '\"' ignore 1 lines"
            cur.execute(query)

        conn.commit()
