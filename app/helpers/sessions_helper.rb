module SessionsHelper

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def login(user)
        session[:user_id] = user.id
    end

    def logged_in?
        !current_user.nil?
    end

    def require_login
        if session[:user_id]
            :ok
        else
            redirect_to login_path
        end
    end
end
