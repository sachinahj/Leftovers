# be ruby lib/databases/table_initializer.rb
require 'pg'

db = PG.connect(host: 'localhost', dbname: 'leftovers')

command = <<-SQL
	CREATE TABLE IF NOT EXISTS restaurants (
	id serial NOT NULL PRIMARY KEY,
	username varchar(30),
	password text,
	address text,
	coordinates text,
	category text
);

	CREATE TABLE IF NOT EXISTS users (
	id serial NOT NULL PRIMARY KEY,
	username varchar(30),
	organization text,
	password text
);

	CREATE TABLE IF NOT EXISTS foods (
	id serial NOT NULL PRIMARY KEY,
	restaurant_id integer REFERENCES restaurants(id),
	name varchar(30),
	description text,
	quantity text
);

	CREATE TABLE IF NOT EXISTS users_session_id (
	id serial NOT NULL PRIMARY KEY,
	user_id integer REFERENCES users(id),
	session_id text
);

	CREATE TABLE IF NOT EXISTS restaurants_session_id (
	id serial NOT NULL PRIMARY KEY,
	restaurant_id integer REFERENCES restaurants(id),
	session_id text
);
SQL

result = db.exec(command)
p result.values
