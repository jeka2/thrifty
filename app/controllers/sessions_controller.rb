class SessionsController < ApplicationController
    before_action :check_logged_in, only: [:new, :create]

    def new
        
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            give_token_to(user)

            redirect_to root_path
        else    
            render :new
        end
    end

    def destroy
        binding.pry
        revoke_token

        redirect_to root_path
    end
private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end 