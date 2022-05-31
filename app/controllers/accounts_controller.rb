class AccountsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_user, only: [ :show, :edit, :destroy, :update ]
  
  def index
    if user_signed_in?
      if current_user.role != 'user'
          @user = User.all
      else
        redirect_to root_path    
      end
    else
        redirect_to new_user_session_path
    end 
  end

  def show
  end

  def edit
  end

  def destroy 
    if current_user.role == 'admin'
      @user.destroy
      redirect_to accounts_path, notice: "User was successfully destroyed."
    elsif current_user.role == 'moderator'
      redirect_to accounts_path
      redirect_to accounts_path, notice: "Just user as role admin who can delete user."
    else
      redirect_to root_path
    end
  end

  def update
    if current_user.role != 'user'
      if @user.update(user_params)
        redirect_to @user, notice: "User was successfully updated."
      else
        render :edit
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
