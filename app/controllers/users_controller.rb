class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!
  before_action :set_last_seen_at, if: :user_signed_in?


  def index
    @users = User.all.page params[:page]
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    @user.update(user_params)
    @user.save
    respond_to do |format|
      format.html { redirect_to user_path(@user.id), notice: 'User was successfully updated!' }
    end
  end

  def update_password
    if @user.update_with_password(password_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Password successfully updated!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_user_path(@user.id), notice: 'Password not updated!' }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :bio, :role, :slug, :avatar)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end  

  def set_last_seen_at
    current_user.update_attribute(:last_seen_at, Time.current)
  end
end
