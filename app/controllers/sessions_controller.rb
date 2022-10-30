class SessionsController < ApplicationController
  before_action :find_session_user, :only, [:create, :destroy]

  def new; end

  def create 
    # @user&.authenticate() == @user && @user.authenticate()
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
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

  def find_session_user
    @user = User.find_by(email: [:session][:email])
  end
end
