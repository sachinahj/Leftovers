module Leftovers
	
	class Users
		attr_reader :username, :organization, :user_id, :password, :session_id

		def initialize(username,organization,user_id = nil, password = nil, session_id = nil)
			@username = username
			@organization = organization
			@user_id = user_id
			@password = password
			@session_id = session_id
		end

		def create!
			@user_id = Leftovers.orm.create_user(@username,@organization)
			return self
		end

		def save!
			Leftovers.orm.update_user(@user_id,@password,@session_id)
			self
		end

		def has_password?(password)
		  @password ==  Digest::SHA1.hexdigest(password)
		end

		def update_password(password)
			@password = Digest::SHA1.hexdigest(password)
		end

		def create_session
     	random_phrase = rand(100).to_s + @username + rand(100).to_s
      @session_id = Digest::SHA1.hexdigest(random_phrase)
      return @session_id
		end
	
	end

end