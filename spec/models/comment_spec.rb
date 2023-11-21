require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規登録' do
    context 'コメント新規登録ができるとき' do 
      it 'すべての情報が揃っている場合' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント新規登録ができないとき' do 
      it 'commentが空の場合' do
        @comment.comment = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
      it 'userが紐づいていない場合' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'planが紐づいていない場合' do
        @comment.plan = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("旅行日程を入力してください")
      end
    end
  end
end