require 'rails_helper'

RSpec.describe "Omniauths", type: :system do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    @pet = FactoryBot.build(:pet)
  end
  context 'Google認証ができるとき' do
    it 'Google認証で新規登録ができるとき' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「新規登録」の文字が確認できる。
      expect(page).to have_content('新規登録')
      
      #サインアップページに遷移する
      visit new_user_registration_path
      #sign up with Googleのボタンをクリックする
      click_button("sign up with Google")

      expect(page).to have_current_path(user_google_oauth2_omniauth_callback_path)
      #Nextボタンをクリックする
      click_button("Next")
      # 遷移先で「わんこ登録」の文字が存在することを確認する
      expect(page).to have_content('わんこ登録')

      # ペット情報を入力する
      fill_in 'pet_name', with: @pet.name
      fill_in 'pet_breed', with: @pet.breed
      choose "pet_size_id_1"
      fill_in 'pet_birthday', with: @pet.birthday

      # サインアップボタンをクリックすると、トップページに遷移する
      click_button("Sign up")
      expect(page).to have_current_path(root_path)
    end

    it 'Google認証でログインができるとき' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「ログイン」の文字が確認できる。
      expect(page).to have_content('ログイン')
      
      #サインインページに遷移する
      visit new_user_session_path

      #sign up with Googleのボタンをクリックする
      click_button("Log in with Google")
      binding.pry
      expect(page).to have_current_path(user_google_oauth2_omniauth_callback_path)

      # サインアップボタンをクリックすると、トップページに遷移する
      expect(page).to have_current_path(root_path)
    end
  end

end
