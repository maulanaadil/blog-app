class AccountsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_user, only: [ :show, :edit, :destroy, :update ]
  
  def index
    @user = User.all
  end

  def show
  end

  def edit
  end

  def destroy 
    @user.destroy
    redirect_to accounts_path, notice: "User was successfully destroyed."
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
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
