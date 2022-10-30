class SessionsController < ApplicationController

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
    session[:user_id].destroy

    redirect_to '/', alert: '您已登出。'
  end

  private

  def session_user_params
    params.require(:session).permit(:email, :password)
  end
end
