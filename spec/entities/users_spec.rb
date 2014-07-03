require_relative './spec_helper'

require 'digest'
require 'spec_helper'
require 'pry-byebug'
require 'pg'

describe Leftover::Users do
	
	before(:all) do
		user = Leftover::Users.new("Winston","NEYL")	
	end

	describe 'initialize' do
		it 'initializes a user with an username and organization' do
			expect(user.username).to eq("Winston")
			expect(user.organization).to eq("NEYL")
		end
	end

	describe 'create!' do
		it "inserts a record into the User database and assigns the database ID to an instance variable" do
			user.create!

			expect(user.user_id).to eq(1)
		end
	end

	describe 'update_password' do
		it "updates the user password with an encrypted passcode" do
			user.update_password("password")

			expect(user.password).to eq(Digest::SHA1.hexdigest(password))
		end
	end

	describe 'has_password?' do
		it "checks to see if the password passed in by the params object is equal to the user password" do
			result = user.has_password?("password")

			expect(user.has_password

		end

end