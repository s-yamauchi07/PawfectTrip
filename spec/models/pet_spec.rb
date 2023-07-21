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
        expect(@pet.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameに半角カタカナが含まれる場合' do
        @pet.name = 'ﾎﾟﾁ'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Name is invalid")
      end
      it 'nameに半角数字が含まれる場合' do
        @pet.name = 'ポチ111'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Name is invalid")
      end
      it 'breedが空の場合' do
        @pet.breed = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Breed can't be blank")
      end
      it 'breedに半角カタカナが含まれる場合' do
        @pet.breed = 'ｼﾊﾞｹﾝ'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Breed is invalid")
      end
      it 'breedに半角英字が含まれる場合' do
        @pet.breed = 'shiba'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Breed is invalid")
      end
      it 'breedに半角数字が含まれる場合' do
        @pet.breed = 'sh1ba'
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Breed is invalid")
      end
      it 'sizeが空の場合' do
        @pet.size_id = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Size must be select")
      end
      it 'birthdayが空の場合' do
        @pet.birthday = ''
        @pet.valid?
        expect(@pet.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
