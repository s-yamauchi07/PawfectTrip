require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグ新規登録' do
    context 'タグの新規登録ができるとき' do 
      it '新規のtagの場合' do
        expect(@tag).to be_valid
      end
    end

    context 'タグの新規登録ができないとき' do 
      it 'タグが重複している場合' do
        @tag.save
        second_tag = FactoryBot.build(:tag)
        second_tag.tag_name = @tag.tag_name
        second_tag.valid?
        expect(second_tag.errors.full_messages).to include("タグはすでに存在します")
      end
    end
  end
end
