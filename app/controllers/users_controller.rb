class UsersController < ApplicationController

  layout 'standard'

  def index
      @users = User.all
   end

  def show; end
end
