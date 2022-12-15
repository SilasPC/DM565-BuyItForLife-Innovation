import sys
import psycopg2

def connect():
	try:
		return psycopg2.connect("dbname='buy_it_for_life' user='admin' host='localhost' password='admin'")
	except Exception as e:
		print(f"Database connection error {e}", file=sys.stderr)
		exit(1)

def setup_tables(conn):
	c = conn.cursor()
	c.execute("""DROP TABLE IF EXISTS market_posts CASCADE""")
	c.execute("""DROP TABLE IF EXISTS posts CASCADE""")
	c.execute("""DROP TABLE IF EXISTS comments CASCADE""")
	c.execute("""CREATE TABLE market_posts(
		id SERIAL PRIMARY KEY,
		title TEXT NOT NULL,
		img TEXT NOT NULL,
		price TEXT NOT NULL
	);""")
	c.execute("""CREATE TABLE posts(
		id SERIAL PRIMARY KEY,
		title TEXT NOT NULL,
		img TEXT NOT NULL,
		stars INT NOT NULL,
		popularity TEXT NOT NULL,
		badge TEXT,
		category TEXT NOT NULL DEFAULT ''
	);""")
	c.execute("""CREATE TABLE comments(
		id SERIAL PRIMARY KEY,
		reviewId INT NOT NULL,
		comment TEXT NOT NULL,
		FOREIGN KEY(reviewId)
			REFERENCES posts
	);""")
	conn.commit()
