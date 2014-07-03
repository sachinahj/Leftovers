module Leftovers

	class LogOut
		
		# looks in the users/restaurants_session_id db and deletes that record using the session ID
		def self.run(session)
			# session :sesh_id, :user, :restaurant
			if session[:restaurant] == nil
				Leftovers.orm.delete_user_session(session[:sesh_id])
			else
				Leftovers.orm.delete_restaurant_session([:sesh_id])
			end
		end

	end
end