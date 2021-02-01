class UsersController < ApplicationController
    before_action :home_if_logged_in, only: [:new, :create]
    
    def index 
        redirect_to signup_path
    end

    def new 
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            give_token_to(@user)

            redirect_to root_path
        else
            set_flash_alert_for(@user)

            render :new

            remove_flash_alert
        end
    end

private 
    def user_params
        params.require(:user).permit(:email, :password, :password, :password_confirmation)
    end
end
