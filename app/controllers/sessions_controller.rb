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
            set_flash_alert_for(user)

            render :new

            remove_flash_alert
        end
    end

    def destroy
        revoke_token

        redirect_to root_path
    end
private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end 