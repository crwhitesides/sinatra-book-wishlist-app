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

  get '/books/new' do
    erb :'/books/create_book'
  end

  post '/books' do
    @book = Book.new(params)

    if @book.title == "" || @book.author == ""
      flash[:message] = "A book just isn't a book without a title and an author..."
      redirect to '/books/new'
    else
      @user = User.find(session[:user_id])
      @user.books << @book
      redirect to "/books/#{@book.id}"
    end
  end
end