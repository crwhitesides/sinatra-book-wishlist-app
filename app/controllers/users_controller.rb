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

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end