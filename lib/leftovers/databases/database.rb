require 'pry-byebug'
require 'pg'

module Leftovers
	class ORM

		def initialize
			@db = PG.connect(host: 'localhost', dbname: "leftovers")
		end

		# Creates a Restaurant entity
		def create_restaurant(username,category,address,coordinates)
			result = @db.exec_params(%Q[ INSERT INTO restaurants (username,category,address,coordinates)
				VALUES ($1,$2,$3,$4) RETURNING id;], [username,category,address,coordinates])

			return result.first["id"]
		end

		# Updates Restaurant entity with encrypted password and session ID
		def update_restaurant(restaurant_id,password,session_id)
			result = @db.exec_params(%Q[ UPDATE users SET(password,session_id)
				= ('#{password}','#{session_id}')	where id = '#{restaurant_id}' returning *])
			result.map! { |x| x }
			return result
		end

		# Creates a User entity 
		def create_user(username,organization)
			result = @db.exec_params(%Q[ INSERT INTO users (username,organization)
				VALUES ($1,$2) RETURNING id;], [username,organization])

			return result.first["id"]
		end

		# Updates User entity with encrypted password and session ID
		def update_user(user_id,password,session_id)
			result = @db.exec_params(%Q[ UPDATE users SET(password,session_id)
				= ('#{password}','#{session_id}')	where id = '#{user_id}' returning *])
			result.map! { |x| x }
			return result
		end

	 	# Gets user through username
	 	def get_user_by_username(username)
	 		result = @db.exec("SELECT * FROM users where username = #{username}")
	 		user = Leftovers::Users.new(result.first["username"],result.first["organization"])
	 		return user
	 	end

	 	# Gets restaurant through username
	 	def get_restaurant_by_username(username)
	 		result = @db.exec("SELECT * FROM restaurant where username = #{username}")
	 		restaurant = Leftovers::Restaurants.new(result.first["username"],result.first["category"],result.first["address"])
	 		return restaurant
	 	end

		# Creates a food entity
		def create_food(name,description,quantity)
			result = @db.exec_params(%Q[ INSERT INTO foods (name,description,quantity)
				VALUES ($1,$2,$3) RETURNING id;], [name,description,quantity])

			return result.first["id"]
		end

	end

	def self.orm
		@___db_instance ||= ORM.new()
	end

end