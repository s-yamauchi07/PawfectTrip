require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができるとき' do 
      it 'すべての情報が揃っている場合' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができないとき' do
      it 'nicknameが空の場合' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nicknameが半角カタカナの場合' do
        @user.nickname = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid")
      end
      it 'nicknameに記号が含まれる場合' do
        @user.nickname = '太郎@'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid")
      end
      it 'nicknameに全角数字が含まれる場合' do
        @user.nickname = '太郎７７７'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid")
      end
      it 'nicknameに全角英字が含まれる場合' do
        @user.nickname = 'ｔａｒｏ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid")
      end
      it 'emailが空の場合' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複している場合' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれない場合' do
        @user.email = "taro.test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空の場合' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字未満の場合' do
        @user.password = "123ab"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが数字のみの場合' do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and at least one number.")
      end
      it 'passwordが英字のみの場合' do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and at least one number.")
      end
      it 'passwordに全角文字が含まれる場合' do
        @user.password = "１２３abc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and at least one number.")
      end
      it 'passwordと確認用passwordが一致しない場合' do
        @user.password = "abc123"
        @user.password_confirmation = "123abc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
