import psycopg2

try:
    conn = psycopg2.connect(
        dbname="postgres",
        user="arman",
        password="arman",
        host="localhost",
        port="5432",
    )

    print(f"Connection success: {conn}")
except psycopg2.OperationalError as e:
    print(f"Connection failed: {e}")
