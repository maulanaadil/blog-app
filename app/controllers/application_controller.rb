class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        # @user = User.find(id: session[:user_id])     
    end  

    def require_user_logged_in!
        redirect_to new_user_session_path, alert: "You must be signed in to do that." if current_user.nil?
    end
end
