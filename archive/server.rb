don# require_relative 'lib/RPS.rb'
require 'sinatra'
require 'pry'
# require 'sinatra-contrib'

enable :sessions 

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :welcome
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
end

get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do
end

get '/donate' do
  erb :donate
end

post '/donate' do
end
get '/logout' do
  session.clear
  redirect to '/'
end

get '/contact' do
  erb :contact
end
