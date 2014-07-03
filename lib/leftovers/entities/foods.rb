module Leftovers
	
	class Foods

		def initialize(name,description,quantity,food_id = nil)
			@name = name
			@description = description 
			@quantity = quantity
			@food_id = food_id
		end

		def create!
			@food_id = Leftovers.orm.create_food(@name,@description,@quantity)
			return self
		end

	end

end