require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    user = FactoryBot.create(:user)
    @buyaddresses = FactoryBot.build(:buyaddress, user_id: user.id)
  end  
    describe '商品購入機能' do
      context '商品購入がうまくいくとき' do
        it '全ての情報が入力されていれば購入できる' do
          expect(@buyaddresses).to be_valid
        end
      end
  
      context '商品購入がうまくいかないとき' do
        it '郵便番号が入力されていなければ購入できない' do
          @buyaddresses.post_code = ''
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("Post code can't be blank")
        end

        it '郵便番号はハイフンがなければ購入できない' do
          @buyaddresses.post_code = 123456
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
        end
  
        it '市町村が入力されていなければ購入できない' do
          @buyaddresses.city = ''
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("City can't be blank.")
        end

        it '市町村は全角以外登録できない' do
          @buyaddresses.city = 'ﾏﾂﾄﾞｼ'
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("City is invalid. Input full-width characters.")
        end
        
        it '番地が空では登録できない' do
          @buyaddresses.address_number = ''
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("Address number can't be blank.")
        end

        it '電話番号が空では登録できない' do
          @buyaddresses.phone_number = ''
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("Phone number can't be blank.")
        end

        it '電話番号にハイフンが入っていると登録できない' do
          @buyaddresses.phone_number = 080-1234-5678
          @buyaddresses.valid?
          expect(@buyaddresses.errors.full_messages).to include("Phone number is invalid.")
        end

        it '都道府県が空だと登録できない' do
          @buyaddresses.prefecture_id = 1
          expect(@buyaddresses.errors.full_messages).to include("Prefecture can't be blank.")
        end

      end  
    end  

end
