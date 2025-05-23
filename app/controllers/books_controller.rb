class BooksController < ApplicationController
  def index
  end

  def show
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(current_user), notice: "Book was successfully created."
    else
      @user = current_user
      @books = @user.books
      render 'users/show'  
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
