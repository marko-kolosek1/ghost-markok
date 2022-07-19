class SettingsController < ApplicationController

  def index
    authorize current_user, :admin?
  end

end
