import mysql.connector

with open("create_functions.sql", "r") as f:
    with mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="gotur",
    ) as conn:
        with conn.cursor() as cur:

            cur.execute(f.read(), multi=True)
