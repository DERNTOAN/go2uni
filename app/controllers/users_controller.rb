class UsersController < ApplicationController
  def index
    @users = User.all
    policy_scope(Ride)
  end

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

  def edit
    @user = current_user
    authorize @user
  end

  def update
    authorize @user
  end

  private
  def user_params
    params.require(:user).permit([:email, :password, :photo, :photo_cache, :first_name, :last_name, :age])
  end
end
