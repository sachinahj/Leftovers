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
		def update_restaurant(restaurant_id,password)
			result = @db.exec_params(%Q[ UPDATE restaurants SET(password)
				= ('#{password}')	where id = '#{restaurant_id}' returning *])
			params = result.map { |x| x }
			return params
		end

	 	# Gets restaurant through username
	 	def check_restaurant_exists(username)
	 		result = @db.exec("SELECT * FROM restaurants where username = '#{username}'")
	 		params = result.map { |x| x }
	 		if params.empty?
	 			return nil
 			else	
	 			restaurant = Leftovers::Restaurants.new(params.first["username"],params.first["category"],result.first["address"])
	 			return restaurant
	 		end
	 	end

	 	def get_restaurant_by_username(username)
	 		result = @db.exec("SELECT * FROM restaurants where username = '#{username}'")
	 		params = result.map { |x| x }
	 		if params.empty?
	 			return nil
 			else	
	 			restaurant = Leftovers::Restaurants.new(params.first["username"],params.first["category"],result.first["address"],result.first["coordinates"],result.first["id"])
	 			return restaurant
	 		end
	 	end

		def create_restaurant_session(restaurant_id)
			puts restaurant_id
			random_phrase = rand(100).to_s + restaurant_id + rand(100).to_s
      session_id = Digest::SHA1.hexdigest(random_phrase)

			result = @db.exec(%Q[ INSERT INTO restaurants_session_id (restaurant_id,session_id)
				VALUES ($1,$2) ], [restaurant_id,session_id])

			return session_id
		end

		# Creates a User entity 
		def create_user(username,organization)
			result = @db.exec_params(%Q[ INSERT INTO users (username,organization)
				VALUES ($1,$2) RETURNING id;], [username,organization])

			return result.first["id"]
		end

		# Updates User entity with encrypted password and session ID
		def update_user(user_id,password)
			result = @db.exec_params(%Q[ UPDATE users SET (password)
				= ('#{password}')	where id = '#{user_id}' returning *])
			params = result.map { |x| x }
			return params
		end

		def create_user_session(user_id)
			random_phrase = rand(100).to_s + user_id + rand(100).to_s
      session_id = Digest::SHA1.hexdigest(random_phrase)

			result = @db.exec(%Q[ INSERT INTO users_session_id (user_id,session_id)
				VALUES ($1,$2) ], [user_id,session_id])

			return session_id
		end

	 	# Gets user through username
	 	def check_user_exists(username)
	 		result = @db.exec("SELECT * FROM users where username = '#{username}'")
			params = result.map { |x| x }
	 		if params.empty?
	 			return nil
	 		else
	 			user = Leftovers::Users.new(params.first["username"],params.first["organization"])
	 			return user
	 		end
	 	end

 	 	def get_user_by_username(username)
	 		result = @db.exec("SELECT * FROM users where username = '#{username}'")
			params = result.map { |x| x }
	 		if params.empty?
	 			return nil
	 		else
	 			puts params
	 			user = Leftovers::Users.new(params.first["username"],params.first["organization"],params.first["id"])
	 			return user
	 		end
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