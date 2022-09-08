class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :set_locale

    skip_before_action :verify_authenticity_token

    around_action :switch_locale

    def set_current_user
        # @user = User.find(id: session[:user_id])     
    end  

    def require_user_logged_in!
        redirect_to new_user_session_path, alert: "You must be signed in to do that." if current_user.nil?
    end

    def default_url_options
        { locale: I18n.locale }
    end

    def switch_locale(&action)
        locale = extract_locale || I18n.default_locale
        I18n.with_locale(locale, &action)
    end

    def extract_locale
        parsed_locale = params[:locale]
        I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end


    private
    def set_locale
        I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      parsed_locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end
end
