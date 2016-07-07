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
    if session[:user_id]
      erb :'/books/create_book'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    @book = Book.find_by(title: params[:title], author: params[:author])
    
    if @book
      flash[:message] = "** It looks like that book is already on your list. **"
      redirect to '/books'
    elsif params[:title] == "" || params[:author] == ""
      flash[:message] = "A book just isn't a book without a title and an author..."
      redirect to '/books/new'
    else
      user = User.find_by_id(session[:user_id])
      @book = Book.create(title: params[:title], author: params[:author], user_id: user.id)
      redirect to "/books/#{@book.slug}"
    end
  end

  get '/books/:slug' do
    if session[:user_id]
      @book = Book.find_by_slug(params[:slug])
      if @book.user_id == session[:user_id]
        erb :'/books/show_book'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  get '/books/:slug/edit' do
    if session[:user_id]
      @book = Book.find_by_slug(params[:slug])
      if session[:user_id] == @book.user_id
        erb :'/books/edit_book'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  patch '/books/:slug' do
    if params[:title] == "" || params[:author] == ""
      flash[:message] = "A book just isn't a book without a title or an author..."
      redirect to "/books/#{@book.slug}/edit"
    else
      @book = Book.find_by_slug(params[:slug])
      @book.title = params[:title]
      @book.author = params[:author]
      @book.save
      redirect to "/books/#{@book.slug}"    
    end
  end

  delete '/books/:slug/delete' do
    if session[:user_id]
      @book = Book.find_by_slug(params[:slug])
      if @book.user_id == session[:user_id]
        @book.delete
        redirect to '/books'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end
end