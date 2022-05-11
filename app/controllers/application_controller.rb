class ApplicationController < ActionController::Base

    def require_user_logged_in!
        redirect_to new_user_session_path, alert: "You must be signed in to do that." if current_user.nil?
    end
end
