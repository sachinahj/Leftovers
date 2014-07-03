module Leftovers
	
	class Users
		attr_reader :username, :organization, :user_id, :password

		def initialize(username,organization,user_id = nil, password = nil)
			@username = username
			@organization = organization
			@user_id = user_id
			@password = password
		end

		def create
			@user_id = Leftovers.orm.create_user(@username,@organization)
			self
		end

		def save
			Leftovers.orm.update_user(@user_id,@password)
			self
		end

		def has_password?(password)
		  @password ==  Digest::SHA1.hexdigest(password)
		end

		def update_password(password)
			@password = Digest::SHA1.hexdigest(password)
		end

		def create_session
			Leftovers.orm.create_user_session(@user_id)
		end
	
	end

end