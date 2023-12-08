require 'rails_helper'

RSpec.describe "HotelLikes", type: :system do
  
  describe '宿泊先のお気に入り登録' do
    
    context '宿泊先のお気に入り登録ができるとき' do
      before do
        @user = FactoryBot.create(:user)
        @prefecture = Prefecture.all.sample[:name]
      end

      it 'ログインしているユーザーは宿泊先のお気に入り登録ができる' do
        # ログインする
        sign_in(@user)

        # 宿検索の文字が表示されていることを確認する
        expect(page).to have_content('宿検索')

        # 宿検索のボタンをクリックする
        click_on('宿検索')

        # 宿検索ページに遷移する
        visit search_hotels_path

        # 「宿泊先検索」の文字があることを確認する
        expect(page).to have_content('宿泊先検索')
        
        # 都道府県を選択する
        select @prefecture, from: 'prefecture'

        # 1つめの検索結果をクリックする
        all('.hotel-card')[0].click
        
        # お気に入りボタンが表示されていることを確認する
        expect(page).to have_selector('.save-fav')

        # お気に入りボタンをクリックすると、hotel_likesモデルのモデルカウントが1増える
        expect{
          find('.save-fav').click
          sleep 1
        }.to change { HotelLike.count }.by(1)

        # 背景色が赤のボタンが表示される。
        expect(page).to have_selector('.cancel-fav')
      end

    end

    context '宿泊先のお気に入り登録ができないとき' do
      it 'ログインしていないユーザーは宿泊先のお気に入り登録ができない' do
        # トップページに移動する
        visit root_path

        # ページ内で宿検索ページへのボタンが確認できない
        expect(page).to have_no_content('宿検索')
      end
      
    end
  end

  describe '宿泊先のお気に入り解除' do
    before do
      @user = FactoryBot.create(:user)
      @hotel = Hotel.create(hotel_num: 181980)
      HotelLike.create(user_id:@user.id, hotel_id:@hotel.id)
    end

    context '宿泊先のお気に入り登録解除ができるとき' do
      it 'ログインしているユーザーは宿泊先のお気に入り登録解除ができる' do
        
        # ログインする
        sign_in(@user)
        
        # メニューアイコンをクリック
        find('.header-icon').click
        
        # ユーザー名が確認できる
        expect(page).to have_content(@user.nickname)
        
        # マイページに遷移する
        click_on(@user.nickname)

        # お気に入り宿の文字が確認できる
        expect(page).to have_content('お気に入り宿')
        # お気に入り宿のタブをクリックする
        all('.tab')[2].click
        
        # お気に入り宿をクリックする
        find('#hotel-info').find('a').click
        
        # お気に入りボタンが表示されていることを確認する
        expect(page).to have_selector('.cancel-fav')

        # お気に入りボタンをクリックすると、hotel_likesモデルのモデルカウントが1減少する
        expect{
          find('.cancel-fav').click
          sleep 1
        }.to change { HotelLike.count }.by(-1)

        # 背景色がグレーのボタンが表示される。
        expect(page).to have_selector('.save-fav')
      end

    end

    context '宿泊先のお気に入り登録解除ができないとき' do
      it 'ログインしていないユーザーは宿泊先のお気に入り登録解除ができない' do
        # トップページに移動する
        visit root_path

        # ページ内で宿検索ページへのボタンが確認できない
        expect(page).to have_no_content('宿検索')
      end
      
    end
  end
end
