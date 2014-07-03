module Leftovers
	
	class SignIn

		def self.run(params)
			# params :username, :password
			user = Leftovers.orm.get_user_by_username(params[:username])
			restaurant = Leftovers.orm.get_restaurant_by_username(params[:username])

			if user ==  nil && restaurant == nil
				return {
					success?: false,
					error: :restaurant_and_user_both_do_not_exist,
					sesh_id: nil,
					user: nil
				}
			elsif user != nil && restaurant == nil
				if user.has_password?(params[:password]) == false
					return {
						success?: false,
						error: :invalid_password,
						sesh_id: nil,
						user: nil
					}
				else
					sesh_id = user.create_session
					user = user.save!
					return {
						success?: true,
						error: :none,
						sesh_id: sesh_id,
						user: user
					}
				end
			else 
				if restaurant.has_password?(params[:password]) == false
					return {
						success?: false,
						error: :invalid_password,
						sesh_id: nil,
						restaurant: nil
					}
				else
					sesh_id = restaurant.create_session
					restaurant = restaurant.save!
					return {
						success?: true,
						error: :none,
						sesh_id: sesh_id,
						restaurant: restaurant
					}
				end
			end

			
		end


	
	end
end