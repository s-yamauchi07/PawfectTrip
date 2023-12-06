require 'rails_helper'

RSpec.describe "PlanLikes", type: :system do

  describe '旅行日程のお気に入り登録' do
    before do
      @plan = FactoryBot.create(:plan)
      @plan2 = FactoryBot.create(:plan)
    end

    context 'お気に入り登録ができるとき' do
      it 'ログインしているユーザーはお気に入り登録ができる' do
      # planを登録したユーザーでログインする
      sign_in(@plan.user)

      # plan2の登録が確認できる
      expect(page).to have_content(@plan2.title)

      #plan2の画像をクリックする
      click_on("plan-image#{@plan2.id}")

      # お気に入りボタンが表示されていることを確認する
      expect(page).to have_selector('.save-fav')

      # お気に入りボタンをクリックすると、plan_likesモデルのモデルカウントが1増える
      expect{
        find('.save-fav').click
        sleep 1
      }.to change { PlanLike.count }.by(1)

      # 背景色が赤のボタンが表示される。
      expect(page).to have_selector('.cancel-fav')
      end
    end
    
    context 'お気に入り登録ができないとき' do
      it 'ログインしていないユーザーはお気に入り登録ができない' do
        # トップページに移動する
        visit root_path
  
        # ページ内にplan2で投稿した内容が確認できる
        expect(page).to have_content(@plan2.title)

        #plan2の画像をクリックする
        click_on("plan-image#{@plan2.id}")

        # お気に入りボタンが表示されていないことを確認する
        expect(page).to have_no_selector('.save-fav')
      end

      it '自身の投稿した日程はお気に入り登録ができない' do
        # planを登録したユーザーでログインする
        sign_in(@plan.user)

        # planの登録が確認できる
        expect(page).to have_content(@plan.title)

        #planの画像をクリックし、自身の登録した日程の詳細ページに移動する
        click_on("plan-image#{@plan.id}")

        # お気に入りボタンが表示されていないことを確認する
        expect(page).to have_no_selector('.save-fav')
      end
    end
  end

  describe '旅行日程のお気に入り削除' do
    before do
      @plan = FactoryBot.create(:plan)
      @plan2 = FactoryBot.create(:plan)
      @plan_like = PlanLike.create(plan_id: @plan2.id, user_id: @plan.user.id)
    end

    context '旅行日程のお気に入り解除ができるとき' do
      it 'ログインしているユーザーはお気に入り登録解除ができる' do
        # planを登録したユーザーでログインする
        sign_in(@plan.user)
  
        # plan2の登録が確認できる
        expect(page).to have_content(@plan2.title)
  
        #plan2の画像をクリックする
        click_on("plan-image#{@plan2.id}")
  
        # お気に入りボタンが表示されていることを確認する
        expect(page).to have_selector('.cancel-fav')
  
        # お気に入りボタンをクリックすると、plan_likesモデルのモデルカウントが1増える
        expect{
          find('.cancel-fav').click
          sleep 1
        }.to change { PlanLike.count }.by(-1)
  
        # 背景色が赤のボタンが表示される。
        expect(page).to have_selector('.save-fav')
      end

    end
    context '旅行日程のお気に入り解除ができないとき' do
      it 'ログインしていないユーザーはお気に入り登録解除ができない' do
        # トップページに移動する
        visit root_path
  
        # ページ内にplan2で投稿した内容が確認できる
        expect(page).to have_content(@plan.title)

        #plan2の画像をクリックする
        click_on("plan-image#{@plan.id}")

        # お気に入りボタンが表示されていないことを確認する
        expect(page).to have_no_selector('.cancel-fav')
      end
      
      it '自身の投稿した日程はお気に入り登録解除ができない' do
        # planを登録したユーザーでログインする
        sign_in(@plan.user)

        # planの登録が確認できる
        expect(page).to have_content(@plan.title)

        #planの画像をクリックし、自身の登録した日程の詳細ページに移動する
        click_on("plan-image#{@plan.id}")

        # お気に入りボタンが表示されていないことを確認する
        expect(page).to have_no_selector('.cancel-fav')
      end
    end
  end
end
