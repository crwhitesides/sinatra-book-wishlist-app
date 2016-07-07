class BooksController < ApplicationController

  get '/books' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @books = @user.books
      erb :'/books/books'
    else
      redirect to '/login'
    end
  end
end