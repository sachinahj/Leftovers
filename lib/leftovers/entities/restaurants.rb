module Leftovers

	class Restaurants 
		attr_reader :username, :category, :address, :coordinates, :restaurant_id

		def initialize(username,category,address,coordinates = nil, restaurant_id = nil, password = nil, session_id = nil)
		 	@username = username
		 	@category = category
		 	@address = address
		 	@coordinates = coordinates
		 	@restaurant_id = restaurant_id
		 	@password = password
		 	@session_id = session_id
		end

		def create!
			@restaurant_id = Leftovers.orm.create_restaurant(@username,@category,@address,@coordinates)
			return self
		end

		def save!
			id_from_db = Leftovers.orm.update_restaurant(@restaurant_id,@password,@session_id)
			self
		end

		def has_password?(password)
		  @password ==  Digest::SHA1.hexdigest(password)
		end

		def update_password(password)
			@password = Digest::SHA1.hexdigest(password)
		end

		def create_session
     	random_phrase = rand(100).to_s + username + rand(100).to_s
      @session_id = Digest::SHA1.hexdigest(random_phrase)
      return @session_id
		end

	end

end