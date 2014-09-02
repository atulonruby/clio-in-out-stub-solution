class UsersController < ApplicationController
  before_filter :only_myself, only: [:edit, :update]

  def index
    @users = User.includes(:team).without_user(current_user)
  end

  def status
    @user = User.find(params[:id])
    User.change_status @user
    @user.save
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user])
    redirect_to users_path
  end

  private

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
