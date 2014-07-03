module Leftovers

	class RestaurantRegistration

		def self.run(params)
			#params :username, :category, :address, :password, :password_confirm
			restaurant = Leftovers.orm.check_restaurant_exists(params[:username])

			if restaurant != nil
				return {
					success?: false,
					error: :restaurant_already_exists,
					sesh_id: nil,
					restaurant: nil
				}
			elsif params[:password] != params[:password_confirm]
				return {
					success?: false,
					error: :passwords_do_not_match,
					sesh_id: nil,
					restaurant: nil
				}
			else
				restaurant = Leftovers::Restaurants.new(params[:username],params[:category],params[:address])
				restaurant.update_password(params[:password])
				restaurant.create
				sesh_id = restaurant.create_session
				restaurant = restaurant.save
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