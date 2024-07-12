require 'rails_helper'

RSpec.describe Pet, type: :model do
  before do
    @pet = FactoryBot.build(:pet)
  end

  describe 'ペット新規登録' do
    context 'ペット情報の新規登録ができるとき' do 
      it 'すべての情報が揃っている場合' do
        expect(@pet).to be_valid
      end
    end

    context 'ペット情報の登録ができない場合' do
      it 'nameが空の場合' do
        @pet.name = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("お名前を入力してください")
      end
      it 'nameに半角カタカナが含まれる場合' do
        @pet.name = 'ﾎﾟﾁ'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("お名前は全角文字または半角英字で入力してください")
      end
      it 'nameに半角数字が含まれる場合' do
        @pet.name = 'ポチ111'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("お名前は全角文字または半角英字で入力してください")
      end
      it 'breedが空の場合' do
        @pet.breed = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("犬種を入力してください")
      end
      it 'breedに半角カタカナが含まれる場合' do
        @pet.breed = 'ｼﾊﾞｹﾝ'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("犬種は全角文字で入力してください")
      end
      it 'breedに半角英字が含まれる場合' do
        @pet.breed = 'shiba'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("犬種は全角文字で入力してください")
      end
      it 'breedに半角数字が含まれる場合' do
        @pet.breed = 'sh1ba'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("犬種は全角文字で入力してください")
      end
      it 'sizeが空の場合' do
        @pet.size_id = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("サイズを選択してください")
      end
    end
  end
end
