class BooksController < ApplicationController

  get '/books' do
    @user = User.find(session[:user_id])
    @books = @user.books
    erb :'/books/books'
  end
end