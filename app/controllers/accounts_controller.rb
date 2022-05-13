class AccountsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_user, only: [ :show, :edit, :destroy ]
  
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

  private

  def set_user
    @user = User.find(params[:id])
  end
end
