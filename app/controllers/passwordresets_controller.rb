class PasswordresetsController < ApplicationController

    def new
    end

    def create
        user = User.find_by_email params[:email]
        if user
            #generate token
            token = reset_token
            user.update reset_token: token
            render text: edit_passwordreset_path(user) + "/?token=#{token}"
            #send email
        else
            flash[:alert] = "Email not found!"
            render :new
        end
    end

    def edit
        @token = params[:token]
    end

    def update
        user = User.find params[:id]
        if (params[:password] == params[:password_confirmation]) && (user.reset_token == params[:token])
            user.update(password: params[:password], reset_token: nil, login_attempt: 0, account_locked: false)
            redirect_to new_session_path, notice: "Password reset! Please login with your new password."
            # render text: "auth_passed"
        elsif !user.reset_token
             flash[:alert] = "No reset token for user"
             render :new
            # render text: "Auth_failed"
        else
            flash[:alert] = "Passwords must be the same"
            redirect_to edit_passwordreset_path(user) + "/?token=#{params[:token]}"
        end
        # render json: params
    end

    private
    def reset_token
        SecureRandom.urlsafe_base64
    end

end
