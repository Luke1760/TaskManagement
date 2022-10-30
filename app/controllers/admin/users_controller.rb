class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index 
    @users = User.all
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.new(set_user_params)

    if @user.save
      redirect_to admin_users_path, notice: "用戶「#{@user.name}」已成功新增。"
    else
      render :new
    end
  end
  
  def show; end

  def edit; end

  def update 
    if @user.update(set_user_params)
      redirect_to admin_users_path, notice: "用戶「#{@user.name}」已被編輯。"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, alert: "用戶「#{@user.name} 已被刪除。" 
    end
  end

  private

  def set_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
