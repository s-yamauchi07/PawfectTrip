class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :withdraw]
  
  def show
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end

end
