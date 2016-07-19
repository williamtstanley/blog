class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by_email params[:email]

        if @user && !@user.account_locked? && @user.authenticate(params[:password])
            sign_in @user
            @user.login_attempt = 0
            redirect_to root_path
        elsif @user && @user.account_locked?
            redirect_to new_passwordreset_path, alert: "Your Account is locked. Reset your password to unlocked the account."
        else
            flash[:alert] = "Incorrect password"
            @user.increment!(:login_attempt)
            if @user.login_attempt >=5
                @user.update(account_locked: true)
            end
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "You have been signed out"
    end
end
