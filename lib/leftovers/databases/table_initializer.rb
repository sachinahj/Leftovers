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
	category text,
	session_id text
);

	CREATE TABLE IF NOT EXISTS users (
	id serial NOT NULL PRIMARY KEY,
	username varchar(30),
	organization text,
	password text,
	session_id text
);

	CREATE TABLE IF NOT EXISTS foods (
	id serial NOT NULL PRIMARY KEY,
	restaurant_id varchar(30) REFERENCE restaurants(id),
	name varchar(30),
	description text,
	quantity text
);
SQL

