require 'digest'

module Leftovers

	class Restaurants 
		attr_reader :username, :category, :address, :coordinates, :restaurant_id

		def initialize(username,category,address,coordinates = nil, restaurant_id = nil, password = nil)
		 	@username = username
		 	@category = category
		 	@address = address
		 	@coordinates = coordinates
		 	@restaurant_id = restaurant_id
		 	@password = password
		end

		def create!
			@restaurant_id = Leftovers.orm.create_restaurant(@username,@category,@address,@coordinates)
			return self
		end

		def save!
			id_from_db = Leftovers.orm.update_restaurant(@restaurant_id,@password)
			self
		end

		def has_password?(password)
		  @password ==  Digest::SHA1.hexdigest(password)
		end

		def update_password(password)
			@password = Digest::SHA1.hexdigest(password)
		end

		def create_session
			Leftover.orm.create_restaurant_session(@user_id)
		end

	end

end