require 'rails_helper'

RSpec.describe Buy, type: :model do
  before do
    user = FactoryBot.create(:user)
    @buyaddresses = FactoryBot.build(:buy, user_id: user.id)
  end

  describe '商品購入機能' do

    context '商品購入がうまくいくとき' do
      it 'tokenがあれば保存できること' do
        expect(@buyaddresses).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'tokenが空では登録できないこと' do
        @buyaddresses.token= nil
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("Token can't be blank")
      end 
    end
  end
end
