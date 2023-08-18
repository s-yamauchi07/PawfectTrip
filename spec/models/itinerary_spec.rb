require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  before do
    @itinerary = FactoryBot.build(:itinerary)
  end

  describe '行程の新規登録' do
    context '行程が新規登録できるとき' do
      it 'すべての情報が揃っている場合' do
        expect(@itinerary).to be_valid
      end
      it 'メモが入力されていない場合でも登録できる' do
        @itinerary.memo = nil
        expect(@itinerary).to be_valid
      end
    end

    context '行程が新規登録できないとき' do
      it '日付と時刻を入力していない場合' do
        @itinerary.date = nil
        @itinerary.valid?
        expect(@itinerary.errors.full_messages).to include("Date can't be blank")
      end
      it '場所を入力していない場合' do
        @itinerary.place = nil
        @itinerary.valid?
        expect(@itinerary.errors.full_messages).to include("Place can't be blank")
      end
      it '移動手段を入力していない場合' do
        @itinerary.transportation_id = nil
        @itinerary.valid?
        expect(@itinerary.errors.full_messages).to include("Transportation must be selected")
      end
      it 'planが紐づいていない場合' do
        @itinerary.plan = nil
        @itinerary.valid?
        expect(@itinerary.errors.full_messages).to include("Plan must exist")
      end
    end
  end
end
