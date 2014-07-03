require 'pg'
require 'sinatra'
require 'pry-byebug'

require_relative './lib/leftovers.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do 
	erb :welcome
end

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

get '/restaurant_home' do
  erb :restaurant_home
end

get '/user_home' do
  erb :user_home
end

get '/sign_in' do
  # add session id check
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
	redirect to '/'
	else
		erb :sign_in
	end
end

get '/contact' do
  erb :contact
end

get '/logout' do
  session.clear
  redirect to '/'
end














