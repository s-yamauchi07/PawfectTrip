module SignInSupport
  def sign_in(user)
    # トップページに移動する
    visit root_path

    #メニューアイコンをクリックする
    find('.header-icon').click

    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('ログイン')

    # ログインページへ遷移する
    visit new_user_session_path

    # 正しいユーザー情報を入力する
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    
    # ログインボタンを押す
    find('input[name="commit"]').click

    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
  end
end