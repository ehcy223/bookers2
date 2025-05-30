class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
      @users = User.all
      @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
      return
    end
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @books = @user.books
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def ensure_correct_user
    redirect_to user_path(current_user) unless @user == current_user
  end
end
