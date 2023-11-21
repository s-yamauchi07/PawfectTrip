require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @pet = FactoryBot.build(:pet)
  end

  context 'ユーザー新規登録できる時' do
    it '正しい情報を入力すれば、トップページに遷移できる(email登録)' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「新規登録」の文字が確認できる。
      expect(page).to have_content('新規登録')
      
      #サインアップページに遷移する
      visit new_user_registration_path
      
      #ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      
      # Nextボタンを押下するとペット情報入力フォームに遷移する
      click_button("Next")

      expect(page).to have_current_path(user_registration_path)

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
  end

  context 'ユーザー新規登録できないとき' do
    it 'ユーザー情報が不足している場合は、新規登録ページにリダイレクトされる' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「新規登録」ボタンが存在する
      expect(page).to have_content('新規登録')

      #サインアップページに遷移する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""

      # Nextボタンを押下するとユーザー新規登録ページに遷移する
      click_button 'Next'
      expect(page).to have_current_path(new_user_registration_path)

      # リダイレクトページで「ユーザー登録」の文字が存在することを確認する
      expect(page).to have_content('ユーザー登録')
    end

    it 'ペット情報が不足している場合は、ペット登録ページにリダイレクトされる' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「新規登録」ボタンが存在する
      expect(page).to have_content('新規登録')

      #サインアップページに遷移する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation

      # Nextボタンを押下するとペット情報入力フォームに遷移する
      click_button("Next")
      expect(page).to have_current_path(user_registration_path)

      # 遷移先で「わんこ登録」の文字が存在することを確認する
      expect(page).to have_content('わんこ登録')

      # ペット情報を入力する
      fill_in 'pet_name', with: ""
      fill_in 'pet_breed', with: ""
      fill_in 'pet_birthday', with: ""
      
      # サインアップボタンをクリックすると、ペット登録ページに遷移する
      click_button("Sign up")
      expect(page).to have_current_path(user_registration_path)
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と入力した情報が合致すればログインができる' do
      #ログインする
      sign_in(@user)

      #メニューアイコンをクリックする
      find('.header-icon').click

      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      #ユーザー名が表示されていることを確認する。
      expect(page).to have_content(@user.nickname)
      
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と入力した情報が合致しなければ、ログインができない' do
      # トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      click_button("sign in")

      # ログインページへ戻されることを確認する
      expect(page).to have_current_path(user_session_path)
    end
  end
end
