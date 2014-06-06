require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

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

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end
