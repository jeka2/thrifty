class ApplicationController < ActionController::Base

private
    def give_token_to(user)
        session[:user_id] = user.id
    end

    def revoke_token
        session[:user_id] = nil
    end

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def check_logged_in
        redirect_to root_path if logged_in?
    end

    def set_flash_alert_for(obj)
        flash[:alert] = obj.errors.full_messages
    end

    def remove_flash_alert
        flash[:alert] = nil
    end

    helper_method :current_user
end
