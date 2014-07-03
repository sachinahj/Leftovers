module Leftovers
	
	class UserRegistration

		def self.run(params)
			# params = { :username, :organization, :password, :password_confirm }
			user = Leftovers.orm.get_user_by_username(params[:username])

			if user.nil?
				return {
					success?: false,
					error: :user_already_exists,
					sesh_id: nil,
					user: nil
				}
			elsif params[:password] != params[:password_confirm]
				return {
					success?: false,
					error: :passwords_do_not_match,
					sesh_id: nil,
					user: nil
				}
			else
				user = Leftovers::Users.new(params[:username],params[:organization])
				user.update_password(params[:password])
				user.create!
				sesh_id = user.create_session
				user = user.save!
				return {
					success?: true,
					error: :none,
					sesh_id: sesh_id
					user: user
				}
		end


	end

end