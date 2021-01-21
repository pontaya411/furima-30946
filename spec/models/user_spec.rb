require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end  
 describe "ユーザー新規登録" do
  it "nicknameが空では登録できない" do
    @user.nickname = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it "emailが空では登録できない" do
    @user.email = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end  

  it "passwordが空では登録できない" do
    @user.password = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end 

  it "パスワードは、6文字以上での入力が必須であること" do
    @user.password = "00000"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end

  it "メールアドレスは、@を含む必要があること" do
    @user.email = "testexaple"
    @user.valid?
    expect(@user.errors.full_messages).to include("Email is invalid")
  end

  it "パスワードとパスワード（確認用）、値の一致が必須であること" do
    @user.password = "000000"
    @user.password_confirmation = "100000"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "重複したemailが存在する場合登録できない" do
    @user.save
    another_user = FactoryBot.build(:user)
    another_user.email = @user.email
    another_user.valid?
    expect(another_user.errors.full_messages).to include("Email has already been taken")
  end
  
 end
end
