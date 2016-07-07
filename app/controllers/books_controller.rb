class BooksController < ApplicationController

  get '/books' do
    @user = User.find(session[:user_id])
    erb :'/books/books'
  end
end