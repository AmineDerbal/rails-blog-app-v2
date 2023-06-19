class RegistrationsController < Devise::RegistrationsController
  private

  ​
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :photo, :bio, :posts_counter)
  end
end
