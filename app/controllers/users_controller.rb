class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect to '/books'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Hold your horses! Make sure you fill in all the fields."
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id 
      redirect to '/books'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to '/books'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username]) 
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/books'
    elsif params[:username] == "" || params[:password] == ""
      flash[:message] = "Oops! Don't forget to fill in both fields."
      redirect to '/login'
    else
      flash[:message] = "It looks like you don't have an account. Sign up now!"
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end