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
        @user = User.find session[:user_id]
        if @user.authenticate params[:password]
            if params[:new_password] == params[:new_password_confirmation]
                @user.update password: params[:new_password]
                redirect_to edit_user_path(current_user), notice: "Password Updated!"
            else
                redirect_to change_password_path, alert: "Passwords must match!"
            end
        else
            redirect_to change_password_path, alert: "Incorrect password"
        end
    end

#     {
#   "password": "test",
#   "new_password": "test",
#   "new_password_confirmation": "test",
#   "action": "update_password"
# }


    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
