require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context "ユーザー新規登録できない場合" do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it "生年月日が空では登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end  
  end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password = '000000'
      @user.password_confirmation = '100000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードは英数字混合であること" do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testexaple'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it "苗字が全角文字であること" do
      @user.last_name = "suzukawa"
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name Full-width characters')
    end

    it "名前が全角文字であること" do
      @user.first_name = "aya"
      @user.valid?
      expect(@user.errors.full_messages).to include('First name Full-width characters')
    end

    it "苗字が全角カナであること" do
      @user.last_name_kana = "ｽｽﾞｶﾜ"
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
    end
    
    it "名前が全角カナであること" do
      @user.first_name_kana = "ｱﾔ"
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end
    
    context "ユーザー新規登録できる場合" do
   
    it "すべての値が正しく入っていればユーザー登録できる" do
      expect(@user).to be_valid
    end
  end  
 end
end
