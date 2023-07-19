# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_nomal_user, only: [:update, :destroy]

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

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
    @pet = @user.pets.build
    render :new_pet, status: :accepted
  end

  def create_pet
    @user = User.new(session["devise.regist_data"]["user"])
    binding.pry
    @pet = Pet.new(pet_params)
      unless @pet.valid?
        render :new_pet, status: :unprocessable_entity and return
      end
    @user.pets.build(@pet.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :breed, :size_id, :birthday)
  end

end
