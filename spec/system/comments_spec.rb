require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @plan = FactoryBot.create(:plan)
    @pet = FactoryBot.create(:pet, user_id: @plan.user.id)
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント新規登録" do
    context 'コメント投稿できるとき' do
      it 'ログインしたユーザーはコメント投稿できる' do
        # ログインする
        sign_in(@plan.user)

        # コメント詳細ページへ遷移する
        move_comment_page(@plan)

        # 入力欄にコメントを記載する
        fill_in 'comment_comment', with: @comment.comment

        # 投稿ボタンをクリックすると、モデルのカウントが1上がる。
        expect{
          find('#comment-btn').click
          sleep 1
        }.to change { Comment.count }.by(1)

        # 投稿した内容がコメント詳細ページで確認できる。
        expect(page).to have_content(@comment.comment)
      end
    end

    context 'コメント投稿できないとき' do
      it 'ログインしていないユーザーはコメント投稿できない' do
        # トップページに遷移する
        visit root_path
        
        # コメント詳細ページへ遷移する
        move_comment_page(@plan)

        # サインインページに遷移する
        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end

  describe "コメント編集" do
    before do
      @plan = FactoryBot.create(:plan)
      @pet = FactoryBot.create(:pet, user_id: @plan.user.id)
      @comment = FactoryBot.create(:comment, plan_id: @plan.id)
      @comment2 = FactoryBot.create(:comment, plan_id: @plan.id)
    end

    context 'コメント編集できるとき' do
      it 'ログインしたユーザーはコメント編集できる' do
        # ログインする
        sign_in(@comment.user)

        # コメント詳細ページへ遷移する
        move_comment_page(@comment.plan)

        # 投稿したコメントが確認できる
        expect(page).to have_content(@comment.comment)
        
        # 編集ボタンが確認できる
        expect(page).to have_link '', href: edit_plan_comment_path(@plan,@comment)
        
        #編集ボタンをクリックする
        click_link('edit-btn')

        # コメント内容を編集する
        fill_in 'comment-edit-form', with: @comment.comment + "編集した内容"

        # 更新ボタンをクリックする
        click_on('更新')

        # 編集した内容が詳細ページに表示される
        expect(page).to have_content(@comment.comment+"編集した内容")
      end
    end

    context 'コメント編集できないとき' do
      it 'ログインしていないユーザーはコメント編集できない' do
        # トップページに遷移する
        visit root_path

        # コメント詳細ページへ遷移する
        move_comment_page(@plan)

        # サインインページに遷移する
        expect(page).to have_current_path(new_user_session_path)
      end

      it '別のユーザーのコメントは編集できない' do
        # @commentを作成したユーザーでログインする
        sign_in(@comment.user)

        # コメント詳細ページへ遷移する
        move_comment_page(@comment.plan)
        
        # 投稿したコメントが確認できる
        expect(page).to have_content(@comment.comment)

        # @commen2の内容も確認できる
        expect(page).to have_content(@comment2.comment)
        
        # comment2に対する編集ボタンが確認できない
        expect(page).to have_no_link '', href: edit_plan_comment_path(@plan,@comment2)
      end
    end
  end

  describe "コメント削除" do
    before do
      @plan = FactoryBot.create(:plan)
      @pet = FactoryBot.create(:pet, user_id: @plan.user.id)
      @comment = FactoryBot.create(:comment, plan_id: @plan.id)
      @comment2 = FactoryBot.create(:comment, plan_id: @plan.id)
    end

    context 'コメント削除できるとき' do
      it 'ログインしたユーザーはコメント削除できる' do
        # ログインする
        sign_in(@comment.user)

        # コメント詳細ページへ遷移する
        move_comment_page(@comment.plan)

        # 投稿したコメントが確認できる
        expect(page).to have_content(@comment.comment)
        
        # 削除ボタンが確認できる
        expect(page).to have_link '', href: plan_comment_path(@plan,@comment)
        
        #編集ボタンをクリックする
        click_link('delete-btn')

        # 編集した内容が詳細ページに表示される
        expect(page).to have_no_content(@comment.comment)
      end
    end

    context 'コメント削除できないとき' do
      it 'ログインしていないユーザーはコメント削除できない' do
        # トップページに遷移する
        visit root_path

        # コメント詳細ページへ遷移する
        move_comment_page(@comment.plan)

        # サインインページに遷移する
        expect(page).to have_current_path(new_user_session_path)
      end
      it '別のユーザーのコメントは削除できない' do
        # @commentを作成したユーザーでログインする
        sign_in(@comment.user)

        # コメント詳細ページへ遷移する
        move_comment_page(@comment.plan)
        
        # 投稿したコメントが確認できる
        expect(page).to have_content(@comment.comment)

        # @commen2の内容も確認できる
        expect(page).to have_content(@comment2.comment)
        
        # comment2に対する編集ボタンが確認できない
        expect(page).to have_no_link '', href: plan_comment_path(@plan,@comment2)
      end
    end
  end
end
