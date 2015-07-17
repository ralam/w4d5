class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Invalid Username/Password Combination"
      render :new
    end

  end

  def show
    if current_user.nil?
      redirect_to new_session_url
      return
    end
    @user = current_user
    render :show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Failed to update user"
      render :edit
    end
  end

  def index
    @users = User.all
  end
end
