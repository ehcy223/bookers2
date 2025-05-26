class BooksController < ApplicationController
  before_action :ensure_book_owner, only: [:edit, :update, :destroy]

  def ensure_book_owner
    book = Book.find(params[:id])
    redirect_to books_path unless book.user == current_user
  end

  def index
    @books = Book.includes(:user).all
    @book = Book.new 
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user 
    @books = @user.books 
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      #@books = @user.books
      render :index
      #@book_form = @book
      #render 'users/show'  
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to book_path(@book)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      Rails.logger.debug "Book updated successfully"
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      Rails.logger.debug "Book update failed: #{@book.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      redirect_to books_path
    else
      redirect_to book_path(@book), alert: "You can't delete this book."
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
