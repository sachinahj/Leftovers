require 'pg'
require 'sinatra'
require 'pry-byebug'

require_relative './lib/leftovers.rb'


set :bind, '0.0.0.0'

enable :sessions

# --------------WELCOME---------------
get '/' do 
	erb :welcome
end

# --------------SIGN UP---------------
get '/sign_up' do
@result =  {
  :success? => nil,
  :error => nil,
  :sesh_id => nil,
  :user => nil
}
	erb :sign_up
end

post '/sign_up' do
	@result = Leftovers::UserRegistration.run(params)
	if @result[:success?]
		session[:sesh_id] = @result[:sesh_id]
		session[:user_id] = @result[:user].user_id
		redirect to '/user_home'
	else
		erb :sign_up
	end
end

get '/donate' do
@result =  {
  :success? => nil,
  :error => nil,
  :sesh_id => nil,
  :user => nil
}
	erb :donate
end

post '/donate' do
	@result = Leftovers::RestaurantRegistration.run(params)
	if @result[:success?]
		session[:sesh_id] = @result[:sesh_id]
		session[:restaurant_id] = @result[:restaurant].restaurant_id
		redirect to '/location_confirm'
	else
		erb :donate
	end
end

get '/location_confirm' do
  session[:restaurant_id]
  @result = Leftovers::GeoLocationFinder.run(session)
  session[:lat_lng] = @result.first
  erb :location_confirm, :layout => false
end

post '/location_confirm' do
  if params["yes"]
    @result = Leftovers::AddLatLng.run(session)
    redirect to '/restaurant_home'
  else
    Leftovers.orm.delete_restaurant_by_id(session[:restaurant_id])
    redirect to '/donate'
  end
end

# --------------RESTAURANTS---------------
get '/restaurant_home' do
  erb :restaurant_home
end

post '/food' do
  #params = {:name, :description, :quantity, :food_url}
  
  redirect '/restaurant_map'
end

get '/restaurant_map' do
  erb :restaurant_map
end

# --------------USERS---------------
get '/user_home' do
  erb :user_home
end

# --------------SIGN IN AND LOGOUT---------------
get '/sign_in' do
	if session[:sesh_id] != nil
		@result = Leftovers::ValidateSession.run(session)
		if @result[:login] == "user"
			redirect '/user_home'
		else
			redirect '/restaurant_home'
		end
	else
		@result =  {
		  :success? => nil,
		  :error => nil,
		  :sesh_id => nil,
		  :user => nil
		}	
			erb :sign_in
	end
end

post '/sign_in' do
	@result = Leftovers::SignIn.run(params)
  p "@result --< #{@result}"
	if @result[:success?] 
		session[:sesh_id] = @result[:sesh_id]
		if @result[:user].nil?
			session[:restaurant_id] = @result[:restaurant].restaurant_id
      redirect to '/restaurant_home'
		else
			session[:user_id] = @result[:user].user_id
      redirect to '/user_home'
		end
	else
		erb :sign_in
	end
end

get '/logout' do
  Leftovers::LogOut.run(session)
  session.clear
  redirect to '/'
end

# --------------CONTACT---------------
get '/contact' do
  erb :contact
end
















