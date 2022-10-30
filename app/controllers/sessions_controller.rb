class SessionsController < ApplicationController
  skip_before_action :login_required

  def new; end

  def create 
    user = User.find_by(email: session_user_params[:email])
    # @user&.authenticate() == @user && @user.authenticate()
    if user&.authenticate(session_user_params[:password])
      session[:user_id] = user.id
      redirect_to '/', notice: '您已成功登入。'
    else
      render :new
    end
  end

  def destroy
    # Resets the session by clearing out all the objects stored within and initializing a new session object.
    reset_session

    redirect_to '/', alert: '您已登出。'
  end

  private

  def session_user_params
    params.require(:session).permit(:email, :password)
  end
end
