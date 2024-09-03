require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
require 'json'
require 'dotenv/load'
## 各種設定ファイル
require "./utils/permission.rb"
require "./utils/setting.rb"

enable :sessions

def logged_in?
    !!session[:user_id]
end

get "/" do
    if logged_in?
        @goods = Good.all
        erb :index
    else
        redirect '/signin'
    end
end

get '/signin' do
    erb :signin
end

post '/signin' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        @user = user
        redirect '/'
    else
        redirect '/signin'
    end
end

get '/signup' do
    erb :signup
end

post '/signup' do
    user = User.create(user_name: params[:user_name], email: params[:email], password: params[:password])
    if user.persisted?
        session[:user_id] = user.id
        redirect '/'
    else
        redirect '/signup'
    end
end

get '/history' do
    user = User.find(session[:user_id])
    @history = user.good
    erb :history
end

get '/admin/product' do
    @goods = Good.all
    erb :products
end

post '/admin/product' do
    price = params[:price].to_i
    Good.create(good_name: params[:good_name], price: price)
    p price
    redirect '/admin/product'
end

get '/product/:good_id' do
    @good = Good.find(params[:good_id])
    erb :product
end

post '/product/:good_id' do
    History.create(user_id: session[:user_id], good_id: params[:good_id].to_i)
    p params[:good_id]
    p session[:user_id]
    redirect 'thanks'
end

get '/thanks' do
    erb :thanks
end

get '/reset' do
    User.delete_all
    Good.delete_all
    History.delete_all
end