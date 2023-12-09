require 'rails_helper'

RSpec.describe "Plans", type: :system do

  describe "旅行日程登録" do
    before do
      @user = FactoryBot.create(:user)
      @pet = FactoryBot.create(:pet, user_id: @user.id)
      @plan = FactoryBot.build(:plan, user_id:@user.id, pet_id:@pet.id)
      @itinerary = FactoryBot.build(:itinerary, plan_id: @plan.id)
    end

    context '旅行日程の新規登録ができるとき' do
      it 'ログインしたユーザーは新規登録できる' do
        #ログインする
        sign_in(@user)
  
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

        # トップページに日程作成ボタンがないことを確認する
        expect(page).to have_no_content('日程作成')
      end

      it '必須項目が空白の場合は、新規登録ができない' do
        #ログインする
        sign_in(@user)
  
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

  describe "旅行日程編集" do
    before do
      @user = FactoryBot.create(:user)
      @pet = FactoryBot.create(:pet, user_id: @user.id)
      @plan = FactoryBot.create(:plan, user_id: @user.id, pet_id:@pet.id)
      @itinerary = FactoryBot.create(:itinerary, plan_id: @plan.id)
      @plan2 = FactoryBot.create(:plan)
    end

    context '旅行日程の編集ができるとき' do
      it 'ログインしたユーザーは自身の登録した旅行日程編集ができる' do
        #ログインする
        sign_in(@user)

        #トップページに登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)

        #画像をクリックする
        click_on("plan-image#{@plan.id}")

        #詳細ページへ遷移する
        expect(page).to have_current_path(plan_path(@plan))
        #編集ボタンがあることを確認する
        expect(page).to have_link '', href: edit_plan_path(@plan)
        
        #編集ボタンをクリックする
        click_link('edit-btn')
        
        #既に投稿済みの内容がフォームに入っていることを確認する(タグ以外)
        expect(@plan.cover_image).to be_attached
        expect(page).to have_field('plan_title', with:@plan.title)
        expect(page).to have_field('plan_departure_date', with:@plan.departure_date.strftime("%Y-%m-%d"))
        expect(page).to have_field('plan_return_date', with:@plan.return_date.strftime("%Y-%m-%d"))
        expect(page).to have_field('plan_departure_id', with:@plan.departure_id)
        expect(page).to have_field('plan_destination_id', with:@plan.destination_id)
        expect(page).to have_field('plan_companion_id', with:@plan.companion_id)
        expect(page).to have_checked_field("#{@pet.name}", visible:false)

        #投稿内容を編集する
        image2_path = Rails.root.join('public/images/no_image.png')
        attach_file('plan[cover_image]', image2_path, visible:false)
        fill_in 'plan_title', with: @plan.title + "編集した内容"

        fill_in 'plan_departure_date', with: Date.new(2023,01,01)
        fill_in 'plan_return_date', with:Date.new(2023,01,03)
  
        select '福岡県', from: 'plan_departure_id'
        select '東京都', from: 'plan_destination_id'
        select '無し(一人)', from: 'plan_companion_id'
        choose "plan_pet_id_#{@pet.id}"
        fill_in 'plan_tag_names', with: "東京旅行"

        # 既に投稿済みの行程内容があることを確認する。
        expect(page).to have_field('plan[itineraries_attributes][0][date]', with:@itinerary.date.strftime("%Y-%m-%dT%H:%M"))
        expect(page).to have_field('plan[itineraries_attributes][0][place]', with: @itinerary.place)
        expect(page).to have_field("plan_itineraries_attributes_0_transportation_id_#{@itinerary.transportation_id}", visible: false, checked: true)

        # 行程の内容変更をする。
        datetime_str = Date.new(2023,11,11).strftime('%Y-%m-%dT%H:%M')
        find('#itinerary_date')
        execute_script("document.getElementById('itinerary_date').value = '#{datetime_str}';")

        fill_in 'itinerary_place', with: "東京タワー"
        fill_in 'itinerary_memo', with: "メモ2"
        #1~6までの数値の中から、@itinarary.transportation_idの数値と一致するものをreject(除外)し、配列化。sampleメソッドで1つ取り出す。
        different_transportation_id = (1..6).to_a.reject { |id| id == @itinerary.transportation_id }.sample
        find(".itinerary_transportation_#{different_transportation_id}").click

        # 日程保存するボタンをクリックする
        click_on('日程保存')
 
        #詳細ページに遷移する
        expect(page).to have_current_path(plan_path(@plan))

        #編集したタイトルが確認できる。
        expect(page).to have_content("#{@plan.title}編集した内容")
      end
    end
    context '旅行日程の編集ができないとき' do
      it 'ログインしていない場合' do
        #トップページに遷移する
        visit root_path

        #トップページに登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)

        # 画像をクリックする
        click_on("plan-image#{@plan.id}")

        # 詳細ページに編集ボタンが存在しないことを確認する。
        expect(page).to have_no_link '', href: edit_plan_path(@plan)
      end

      it 'ログインユーザーと旅行日程登録者が別ユーザーの場合' do
        # @plan2を作成したユーザーでログインする
        sign_in(@plan2.user)

        #トップページに@userが登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)  

        #@planの画像をクリックする
        click_on("plan-image#{@plan.id}")

        # 詳細ページに編集ボタンが存在しないことを確認する。
        expect(page).to have_no_link '', href: edit_plan_path(@plan)

      end
    end
  end

  describe "旅行日程削除" do
    before do
      @user = FactoryBot.create(:user)
      @pet = FactoryBot.create(:pet, user_id: @user.id)
      @plan = FactoryBot.create(:plan, user_id: @user.id, pet_id:@pet.id)
      @plan2 = FactoryBot.create(:plan)
    end

    context '旅行日程の削除ができるとき' do
      it 'ログインしたユーザーは自身の登録した旅行日程削除ができる' do
        #ログインする
        sign_in(@user)

        #トップページに登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)

        #画像をクリックする
        click_on("plan-image#{@plan.id}")

        #詳細ページへ遷移する
        expect(page).to have_current_path(plan_path(@plan))

        #削除ボタンがあることを確認する
        expect(page).to have_selector('.delete-btn')
        
        #削除ボタンをクリックする
        find('.delete-btn').click

        #削除用のモーダルが表示されていることを確認する。
        expect(page).to have_selector('.modal-box')

        # 確認用モーダル内に削除確認用のメッセージが確認できる。
        within('.modal-box') do
          expect(page).to have_content('本当に日程を削除しますか？')

          # 「はい」のボタンをクリックする
          click_button('はい')
        end

        #トップページから投稿した内容が削除されていることを確認する。
        expect(page).to have_no_content(@plan.title)
      end
    end
    context '旅行日程の削除ができないとき' do
      it 'ログインしていない場合' do
        #トップページに遷移する
        visit root_path

        #トップページに登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)

        # 画像をクリックする
        click_on("plan-image#{@plan.id}")

        # 詳細ページに編集ボタンが存在しないことを確認する。
        expect(page).to have_no_selector('.delete-btn')
      end

      it 'ログインユーザーと旅行日程登録者が別ユーザーの場合' do
        # @plan2を作成したユーザーでログインする
        sign_in(@plan2.user)

        #トップページに@userが登録した旅行日程のタイトルが表示されていることを確認する。
        expect(page).to have_content(@plan.title)  

        #@planの画像をクリックする
        click_on("plan-image#{@plan.id}")

        # 詳細ページに編集ボタンが存在しないことを確認する。
        expect(page).to have_no_selector('.delete-btn')
      end
    end
  end
end
