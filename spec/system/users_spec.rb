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

RSpec.describe "ログアウト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログアウトできるとき' do
    it 'ログイン状態のユーザーはログアウトができる' do
      # ログインする
      sign_in(@user)

      #メニューアイコンをクリックする
      find('.header-icon').click

      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')

      # ログアウトボタンをクリックする
      click_on('ログアウト')

      # トップページに遷移する
      expect(current_path).to eq root_path

      # メニューアイコンをクリックし、ログアウトボタンがないことを確認する
      expect(
        find('.header-icon').click
    ).to have_no_content('ログアウト')

    end
  end

  context 'ログアウトできないとき' do
    it 'ログインしていないユーザーはログアウトができない' do
      # トップページに遷移する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      # トップページにログアウトボタンがないことを確認する
      expect(page).to have_no_content('ログアウト')
    end
  end
end

RSpec.describe "ユーザー編集", type: :system do
  before do 
    @user = FactoryBot.create(:user)
    @pet = FactoryBot.create(:pet, user_id: @user.id)
    @plan = FactoryBot.create(:plan)
  end


  context 'ユーザー編集できるとき' do
    it 'ログインしたユーザーはユーザー編集できる' do
      # ログインする
      sign_in(@user)

      #メニューアイコンをクリックする
      find('.header-icon').click

      # ユーザー名が表示されていることを確認する。
      expect(page).to have_no_content(@user.nickname)

      # ユーザー名をクリックする
      click_on(@user.nickname)

      # 編集ボタンがあることを確認する
      expect(page).to have_selector('#user-edit-btn')
      
      # 編集ボタンをクリックする
      find('#user-edit-btn').click
      
      # ユーザー編集の文字があることを確認する
      expect(page).to have_content('ユーザー編集')
      
      #ユーザー情報を編集する
      fill_in 'user_nickname', with: @user.nickname + "編集"
      fill_in 'user_email', with: "edit." + @user.email
      fill_in 'user_password', with: @user.password + "password"
      fill_in 'user_password_confirmation', with: @user.password_confirmation + "password"
      
      # Nextボタンを押下するとペット情報編集フォームに遷移する
      click_on("Next")

      # 遷移先で「わんこ登録」の文字が存在することを確認する
      expect(page).to have_content('わんこ編集')

      # ペット情報を入力する
      fill_in 'pet_name', with: @pet.name + "編集"
      fill_in 'pet_breed', with: @pet.breed + "編集"
      choose "pet_size_id_2"
      
      # アップデートボタンをクリックする
      click_button("update")

      # 編集したユーザー名・ペット名が表示されていることを確認する
      expect(page).to have_content(@user.nickname + "編集")
      expect(page).to have_content(@pet.name + "編集")

    end
  end
  context 'ユーザー編集できないとき' do
    it 'ログインしていないユーザーはユーザー編集できない' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「ユーザー名」が確認できない。
      expect(page).to have_no_content(@user.nickname)
    end

    it '別のユーザーの情報編集はできない' do
      # @userでログインする
      sign_in(@user)

      # トップページに@planのタイトルがあることを確認する
      expect(page).to have_content(@plan.title)

      # @planの詳細ページに遷移する
      click_on("plan-image#{@plan.id}")

      # ユーザー名が存在することを確認する
      expect(page).to have_content(@plan.user.nickname)

      # ユーザー名をクリックする
      click_on"#{@plan.user.nickname}'s trip plan"

      # 編集ボタンがないことを確認する
      expect(page).to have_no_selector('#user-edit-btn')
    end
  end
end

RSpec.describe "ユーザー削除(アカウント削除)", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @pet = FactoryBot.create(:pet, user_id:@user.id)
    @plan = FactoryBot.create(:plan)
  end

  context 'ユーザー削除できるとき' do
    it 'ログインしたユーザーはユーザー削除できる' do
      # ログインする
      sign_in(@user)

      #メニューアイコンをクリックする
      find('.header-icon').click

      # ユーザー名が表示されていることを確認する。
      expect(page).to have_no_content(@user.nickname)

      # ユーザー名をクリックする
      click_on(@user.nickname)

      # 削除ボタンがあることを確認する
      expect(page).to have_selector('#unsubscribe-btn')

      find('#unsubscribe-btn').click

      # 確認用メッセージが表示されていることを確認する
      expect(page).to have_content('本当に退会しますか？')

      # 退会するボタンをクリックする
      click_button('退会する')

      # 退会処理が完了しましたの文字が確認できる
      expect(page).to have_content('退会処理が完了しました')
    end
  end

  context 'ユーザー削除できないとき' do
    it 'ログインしていないユーザーはユーザー削除できない' do
      #トップページに移動する
      visit root_path

      #メニューアイコンをクリックする
      find('.header-icon').click

      #トップページに「ユーザー名」が確認できない。
      expect(page).to have_no_content(@user.nickname)
    end

    it '別のユーザーの情削除はできない' do
      # @userでログインする
      sign_in(@user)

      # トップページに@planのタイトルがあることを確認する
      expect(page).to have_content(@plan.title)

      # @planの詳細ページに遷移する
      click_on("plan-image#{@plan.id}")

      # ユーザー名が存在することを確認する
      expect(page).to have_content(@plan.user.nickname)

      # ユーザー名をクリックする
      click_on"#{@plan.user.nickname}'s trip plan"

      # 編集ボタンがないことを確認する
      expect(page).to have_no_selector('#unsubscribe-btn')
    end
  end
end