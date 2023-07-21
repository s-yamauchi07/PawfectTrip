require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録できる時' do
    it '正しい情報を入力すれば、ペット情報入力ページに遷移できる' do
    #トップページに移動する
    visit root_path
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
    click_button 'Next'
    expect(current_path).to eq(new_user_registration_path)

    # 遷移先で「わんこ登録」の文字が存在することを確認する
    expect(page).to have_content('わんこ登録')
    end
  end

  context 'ユーザー新規登録できないとき' do
    it '情報が不足している場合は、新規登録ページにリダイレクトされる' do
    #トップページに移動する
    visit root_path

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
    expect(current_path).to eq(new_user_registration_path)

    # リダイレクトページで「ユーザー登録」の文字が存在することを確認する
    expect(page).to have_content('ユーザー登録')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と入力した情報が合致すればログインができる' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      
      # ログインボタンを押す
      find('input[name="commit"]').click
      
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)

      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')

      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と入力した情報が合致しなければ、ログインができない' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''

      # ログインボタンを押す
      click_button 'Log in'

      # ログインページへ戻されることを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end
