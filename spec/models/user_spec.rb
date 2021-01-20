require 'rails_helper'

RSpec.describe User, type: :model do
 describe "ユーザー新規登録" do
  it "nicknameが空では登録できない" do
    user = User.new(nickname: "", email: "test@example", password: "000000", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("Nickname can't be blank")
  end
  it "emailが空では登録できない" do
    user = User.new(nickname: "aya", email: "", password: "000000", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("Email can't be blank")
  end  
  it "passwordが空では登録できない" do
    user = User.new(nickname: "aya", email: "test@example", password: "", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("Password can't be blank")
  end 
  it "パスワードは、6文字以上での入力が必須であること" do
    user = User.new(nickname: "aya", email: "test@example", password: "00000", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end
  it "メールアドレスは、@を含む必要があること" do
    user = User.new(nickname: "aya", email: "test@example", password: "00000", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("メールアドレスに「＠」を挿入してください")
  end
  it "パスワードとパスワード（確認用）、値の一致が必須であること" do
  user = User.new(nickname: "aya", email: "test@example", password: "000000", password_confirmation: "100000")
    user.valid?
    expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end
  it "重複したemailが存在する場合登録できないこと" do
    user = User.new(nickname: "aya", email: "ayatomita1@gmail.com", password: "000000", password_confirmation: "000000")
    user.valid?
    expect(user.errors.full_messages).to include("Email has already been taken")
  end
 end
end
