class UsersController < ApplicationController


  def new
    @user = User.new

  end

  def create
    u = User.create(user_params)
    if u.save
      # UserMailer.creation_confirmation(u).deliver_now
      redirect_to u_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit([:email, :password, :photo, :photo_cache, :first_name, :last_name, :age])
  end
end
