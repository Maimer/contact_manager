require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'

get '/' do
  if params[:page] != nil
    @page = params[:page].to_i
  else
    @page = 1
  end
  @total = Contact.all.size
  @contacts = Contact.all.limit(2).offset((@page * 2) - 2)
  erb :index
end

post '/' do
  @contacts = Contact.where(first_name: params[:search])
  @total = @contacts.size
  erb :index
end

post '/add' do
  @firstname = params[:first_name]
  @lastname = params[:last_name]
  @phonenumber = params[:phone_number]
  Contact.find_or_create_by(first_name: @firstname, last_name:
    @lastname, phone_number: @phonenumber)

  redirect '/'
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end
