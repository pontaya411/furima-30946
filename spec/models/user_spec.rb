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
 end
end
