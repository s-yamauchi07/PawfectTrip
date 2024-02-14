require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = FactoryBot.build(:plan)
  end

  describe '予定新規登録' do
    context '予定の新規登録ができるとき' do 
      it 'すべての情報が揃っている場合' do
        expect(@plan).to be_valid
      end

      it '画像が空でも登録できる' do
        @plan.cover_image = nil
        expect(@plan).to be_valid
      end

      it 'タグが空でも登録できる' do
        @plan.tag = nil
        expect(@plan).to be_valid
      end
    end

    context '予定の登録ができない場合' do
      it 'タイトルが空の場合' do
        @plan.title = ""
        @plan.valid?
        expect(@plan.errors.full_messages).to include("タイトルを入力してください")
      end
      it '出発日が空の場合' do
        @plan.departure_date = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("出発日を入力してください")
      end
      it '帰着日が空の場合' do
        @plan.return_date = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("帰着日を入力してください")
      end
      it '出発地が未選択の場合' do
        @plan.departure_id = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("出発地を選択してください")
      end
      it '目的地が未選択の場合' do
        @plan.destination_id = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("目的地を選択してください")
      end
      it '同伴者が未選択の場合' do
        @plan.companion_id = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("同伴者を選択してください")
      end
      it '同伴わんこが選択されていない場合' do
        @plan.pet = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("同行わんこを入力してください")
      end
      it 'userが紐づいていない場合' do
        @plan.user = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include("ユーザーを入力してください")
      end
    end
  end
end
