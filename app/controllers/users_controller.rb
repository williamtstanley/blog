class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            sign_in @user
            redirect_to root_path, notice: "Thank you for signing up!"
        else
            render :new
        end
    end

    def edit
        @user = current_user
    end

    def update
        @user = User.find session[:user_id]
        user_params = params.require(:user).permit(:first_name, :last_name, :email)
        if @user.update user_params
            redirect_to root_path
        else
            render :edit
        end
    end

    def change_password
        @user = User.find session[:user_id]
    end
    def update_password
        
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
