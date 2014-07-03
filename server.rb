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
  p "@result --> #{@result.inspect}"
	if @result[:success?]
		session[:sesh_id] = @result[:sesh_id]
		session[:user] = @result[:user].user_id
		redirect to '/'
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
		session[:restaurant] = @result[:restaurant].restaurant_id
		redirect '/'
	else
		erb :donate
	end
end

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

	if @result[:success?] 
		session[:sesh_id] = @result[:sesh_id]
		if @result[:user].nil?
			session[:restaurant] = @result[:restaurant].restaurant_id
		else
			session[:user] = @result[:user].user_id
		end
	redirect '/'
	else
		erb :sign_in
	end
end

get '/contact' do
  erb :contact
end

get '/logout' do
	Leftovers::Logout.run(session)
  session.clear
  redirect to '/'
end














