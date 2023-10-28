# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: [:update, :destroy]

  def new
    #@user = User.newと同意。
    super
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new, status: :unprocessable_entity and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @pet = @user.build_pet
    render :new_pet, status: :accepted
  end

  def edit
    super
  end

  def update
    @user = current_user
    unless @user.update(account_update_params)
      render :edit, status: :unprocessable_entity and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @pet = Pet.find_by(user_id: @user.id)
    render :edit_pet, status: :accepted
  end

  def create_pet
    @user = User.new(session["devise.regist_data"]["user"])
    @pet = Pet.new(pet_params)
      unless @pet.valid?
        render :new_pet, status: :unprocessable_entity and return
      end
    @user.build_pet(@pet.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end

  def update_pet
    @user = User.find(session["devise.regist_data"]["user"]["id"])
    @pet = Pet.find_by(user_id: @user.id)
    unless @pet.update(pet_params)
      render :edit_pet, status: :unprocessable_entity and return
    end
    sign_in(:user, @user)
    redirect_to user_path(@user)
    
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :breed, :size_id, :birthday)
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

end
