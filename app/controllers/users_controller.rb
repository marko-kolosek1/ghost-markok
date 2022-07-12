class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    authorize @user
  end

  def update
    @user.update(user_params)
    @user.save
    respond_to do |format|
      format.html { redirect_to user_path(@user.id), notice: 'User was successfully updated!' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :bio, :role, :slug, :avatar)
  end 
end
