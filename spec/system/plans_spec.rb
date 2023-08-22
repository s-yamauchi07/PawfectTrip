require 'rails_helper'

RSpec.describe "Plans", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @pet = FactoryBot.create(:pet, user_id: @user.id)
    @plan = FactoryBot.build(:plan)
    @itinerary = FactoryBot.build(:itinerary, plan_id: @plan.id)
  end

  describe "旅行日程登録" do
    context '旅行日程の新規登録ができるとき' do
      it 'ログインしたユーザーは新規登録できる' do
        #ログインする
        sign_in(@user)
  
        #メニューアイコンをクリックする
        find('.header-icon').click
  
        # 日程作成ボタンがあることを確認する
        expect(page).to have_content('日程作成')
  
        # 日程作成ボタンをクリックする
        click_link('日程作成')
  
        #日程登録ページに遷移したことを確認する
        expect(page).to have_current_path(new_plan_path)
  
        #入力フォームに値を入力する
        image_path = Rails.root.join('public/images/test_image.jpg')
        attach_file('plan[cover_image]', image_path)
  
        fill_in 'plan_title', with: @plan.title
        fill_in 'plan_departure_date', with: @plan.departure_date
        fill_in 'plan_return_date', with: @plan.return_date
  
        select '東京都', from: 'plan_departure_id'
        select '大阪府', from: 'plan_destination_id'
        select '友人', from: 'plan_companion_id'
        choose "plan_pet_id_#{@pet.id}"
        fill_in 'plan_tag_names', with: @plan.tag
  
        # 行程追加するボタンをクリックする
        find('.btn-warning').click
        
        #行程追加の文字があることを確認する
        expect(page).to have_content('行程追加')
  
        fill_in 'itinerary_date', with:@itinerary.date
        fill_in 'itinerary_place', with:@itinerary.place
        fill_in 'itinerary_memo', with:@itinerary.memo
        
        #画像をクリックする
        find(".itinerary_transportation_#{@itinerary.transportation_id}").click
  
        #radioに値が入っていることを確認する
        expect(page).to have_checked_field with: @itinerary.transportation_id, visible: false
  
        # 日程保存ボタンをクリックすると、planモデルのデータがひとつ増える。
        expect {
          click_on('日程保存')
          sleep 1
        }.to change { Plan.count }.by(1)
  
        #トップページに遷移する
        expect(page).to have_current_path(root_path)
      end
    end
  
    context '旅行日程の新規登録ができないとき' do
      it 'ログインしていないと新規登録ができない' do
        #トップページに遷移する
        visit root_path

        #メニューアイコンをクリックする
        find('.header-icon').click
  
        # トップページに日程作成ボタンがないことを確認する
        expect(page).to have_no_content('日程作成')
      end

      it '必須項目が空白の場合は、新規登録ができない' do
        #ログインする
        sign_in(@user)
        
        #メニューアイコンをクリックする
        find('.header-icon').click
  
        # 日程作成ボタンがあることを確認する
        expect(page).to have_content('日程作成')
  
        # 日程作成ボタンをクリックする
        click_link('日程作成')
  
        #日程登録ページに遷移したことを確認する
        expect(page).to have_current_path(new_plan_path)
  
        #入力フォームに空の値を入力する
        image_path = Rails.root.join('')
        attach_file('plan[cover_image]', image_path)
  
        fill_in 'plan_title', with: ''
        fill_in 'plan_departure_date', with: ''
        fill_in 'plan_return_date', with:''
  
        select '---', from: 'plan_departure_id'
        select '---', from: 'plan_destination_id'
        select '---', from: 'plan_companion_id'
        expect(page).to have_unchecked_field(@pet.name)
        fill_in 'plan_tag_names', with: ''
  
        # 行程追加するボタンをクリックする
        find('.btn-warning').click
        
        #行程追加の文字があることを確認する
        expect(page).to have_content('行程追加')
  
        fill_in 'itinerary_date', with: ''
        fill_in 'itinerary_place', with: ''
        fill_in 'itinerary_memo', with:''
        
        #radioに値が入っていることを確認する
        expect(page).to have_unchecked_field with: '', visible: false
  
        # 日程保存ボタンをクリックすると、planモデルのデータがひとつ増える。
        expect {
          click_on('日程保存')
          sleep 1
        }.to change { Plan.count }.by(0)
  
        #新規投稿ページにリダイレクトする
        expect(page).to have_current_path(new_plan_path)
      end
    end
  end
end
