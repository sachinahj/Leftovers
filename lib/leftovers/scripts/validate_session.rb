module Leftovers
	class ValidateSession

		def self.run(params)

			user = Leftovers.orm.validate_user_session?(params)
			restaurant = Leftovers.orm.validate_restaurant_session?(params)

			puts "THIS IS USER: #{user}"
			puts "THIS IS RESTAURANT: #{restaurant}"
			if user == false && restaurant == false
				return {
					success?: false,
					error: :user_restaurant_do_not_exist,
					login: nil
				}
			elsif user == true && restaurant == false
				return {
					success?: true,
					error: nil,
					login: "user"
				}
			elsif restaurant == true && user == false
				return {
					success?: true,
					error: nil,
					login: "restaurant"
				}
			end

		end
	end
end