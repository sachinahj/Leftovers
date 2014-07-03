require 'pg'
require 'sinatra'
require 'pry-byebug'

# require_relative '/lib/leftovers/entities/restaurants.rb'
require_relative 'lib/leftovers/entities/users.rb'
require_relative 'lib/leftovers/entities/foods.rb'
require_relative 'lib/leftovers/entities/restaurants.rb'
require_relative 'lib/leftovers/databases/database.rb'
require_relative 'lib/leftovers/scripts/user_registration.rb'
require_relative 'lib/leftovers/scripts/sign_in.rb'
require_relative 'lib/leftovers/scripts/restaurant_registration.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do 
	erb :welcome
end

get '/user_registration' do
@result =  {
  :success? => nil,
  :error => nil,
  :sesh_id => nil,
  :user => nil
}
	erb :user_registration
end

post '/user_registration' do
	@result = Leftovers::UserRegistration.run(params)
	if @result[:success?]
		session[:sesh_id] = @result[:sesh_id]
		session[:user] = @result[:user]
		redirect to '/home'
	else
		erb :user_registration
	end
end

get '/restaurant_registration' do
@result =  {
  :success? => nil,
  :error => nil,
  :sesh_id => nil,
  :user => nil
}
	erb :restaurant_registration
end

post '/restaurant_registration' do
	@result = Leftovers::RestaurantRegistration.run(params)
	if @result[:success?]
		session[:sesh_id] = @result[:sesh_id]
		session[:restaurant] = @result[:restaurant]
		redirect '/home'
	else
		erb :restaurant_registration
	end
end

get '/sign_in' do
@result =  {
  :success? => nil,
  :error => nil,
  :sesh_id => nil,
  :user => nil
}	
	erb :sign_in
end

post '/sign_in' do
	@result = Leftovers::SignIn.run(params)

	if @result[:success?] 
		session[:sesh_id] = @result[:sesh_id]
		if @result[:user].nil?
			session[:restaurant] = @result[:restaurant]
		else
			session[:user] = @result[:user]
		end
	redirect '/home'
	else
		erb :sign_in
	end
end

get '/logout' do
  session.clear
  redirect to '/'
end