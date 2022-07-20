class Api::V1::UsersController < ApplicationController
  before_action :set_user, except: [:index]

  before_action :restrict_access

  respond_to :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
    @stories = @user.stories;
    respond_with @stories
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end
