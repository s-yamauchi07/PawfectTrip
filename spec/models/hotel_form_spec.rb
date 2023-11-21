require 'rails_helper'

RSpec.describe HotelForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @hotelform = FactoryBot.build(:hotel_form, user_id: @user.id)
  end

  describe 'ホテルのお気に入り登録' do
    context 'ホテルのお気に入り登録ができるとき' do 
      it 'すべての情報が揃っている場合' do
        expect(@hotelform).to be_valid
      end
    end

    context 'ホテルのお気に入り登録ができないとき' do 
      it 'ホテルNoが空の場合' do
        @hotelform.hotel_num = ''
        @hotelform.valid?
        expect(@hotelform.errors.full_messages).to include("ホテルNoを入力してください")
      end
      it 'user_idが空の場合' do
        @hotelform.user_id = nil
        @hotelform.valid?
        expect(@hotelform.errors.full_messages).to include("ユーザーを入力してください")
      end
    end
  end
end
