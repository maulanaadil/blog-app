class AccountsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_user, only: [ :show, :edit, :destroy, :update ]
  
  def index
    if current_user.role != 'user'
        @user = User.all
    else
      redirect_to root_path, notice: t('.notice')    
    end
  end

  def show
    case current_user
    when 'user'
      redirect_to root_path, notice: t('.notice') 
    else
      redirect_to root_path, notice: t('.notice_undifined') 
    end
  end

  def edit
    case current_user
    when 'user'
      redirect_to root_path, notice: t('.notice') 
    else
      redirect_to root_path, notice: t('.notice_undifined') 
    end
  end

  def destroy 
    case current_user
    when 'admin'
      @user.destroy
      redirect_to accounts_path, notice: t('.notice_admin') 
    when 'moderator'
      redirect_to accounts_path, notice: t('.notice_moderator')
    else
      redirect_to root_path, notice: t('.notice_error')
    end
  end

  def update
    if current_user.role != 'user'
      if @user.update(user_params)
        redirect_to @user, notice: t('.notice_success')
      else
        render :edit, notice: t('.notice_failure')
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
