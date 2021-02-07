class SessionsController < ApplicationController
    before_action :home_if_logged_in, only: [:new, :create]

    def new
        
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            give_token_to(user)

            redirect_to root_path
        else    
            flash[:alert] = ["Wrong Credentials"]

            render :new

            remove_flash_alert
        end
    end

    def destroy
        revoke_token

        redirect_to root_path
    end

    def google 
        @user = User.find_or_create_by(email: auth['info']['email']) do |user|
            user.password = SecureRandom.hex(10) + '!B'
        end
        if @user && @user.id
            give_token_to @user
            redirect_to root_path
        else
            redirect_to login_path
        end
        
    end
private
    def auth
        request.env['omniauth.auth']
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
end 