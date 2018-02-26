class UsersController < ApplicationController


  def new
    @user = User.new

  end

  def create
    u = User.create(user_params)
    redirect_to u_path
  end

  private
  def user_params
    params.require(:user).permit([:email, :password, :photo, :photo_cache, :first_name, :last_name, :age])
  end
end
