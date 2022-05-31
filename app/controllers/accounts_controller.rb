class AccountsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_user, only: [ :show, :edit, :destroy, :update ]
  
  def index
    if current_user.role != 'user'
        @user = User.all
    else
      redirect_to root_path, notice: "Just user as role admin and moderator can access this page."    
    end
  end

  def show
    if current_user.role == 'user'
      redirect_to root_path, notice: "Just user as role admin and moderator can access this page."    
    end
  end

  def edit
    if current_user.role == 'user'
      redirect_to root_path, notice: "Just user as role admin and moderator can access this page."    
    end
  end

  def destroy 
    if current_user.role == 'admin'
      @user.destroy
      redirect_to accounts_path, notice: "User was successfully destroyed."
    elsif current_user.role == 'moderator'
      redirect_to accounts_path, notice: "Just user as role admin who can delete user."
    else
      redirect_to root_path, notice: "Just user as role admin who can delete user."
    end
  end

  def update
    if current_user.role != 'user'
      if @user.update(user_params)
        redirect_to @user, notice: "User was successfully updated."
      else
        render :edit, notice: "Nothing updated! Only user as role admin and moderator can update the user."
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
