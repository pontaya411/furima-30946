require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buyaddresses = FactoryBot.build(:buy_address, user_id: user.id, item_id: item.id)
  end
  describe '商品購入機能' do
    context '商品購入がうまくいくとき' do
      it '全ての情報が入力されていれば購入できる' do
        expect(@buyaddresses).to be_valid
      end

       it '建物名が空でも登録できる' do
         @buyaddresses.building_name = ''
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
        @buyaddresses.post_code = 123_456
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include('Post code is invalid. Include hyphen(-).')
      end

      it '市町村が入力されていなければ購入できない' do
        @buyaddresses.city = ''
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("City can't be blank",
                                                              'City is invalid. Input full-width characters.')
      end

      it '市町村は全角以外登録できない' do
        @buyaddresses.city = 'ﾏﾂﾄﾞｼ'
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include('City is invalid. Input full-width characters.')
      end

      it '番地が空では登録できない' do
        @buyaddresses.address_number = ''
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("Address number can't be blank")
      end

      it '電話番号が空では登録できない' do
        @buyaddresses.phone_number = ''
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は英数混合だと登録できない' do
      @buyaddresses.phone_number = '1a23456789'
      @buyaddresses.valid?
      expect(@buyaddresses.errors.full_messages).to include("Phone number is invalid.")
      end

      it '電話番号にハイフンが入っていると登録できない' do
        @buyaddresses.phone_number = 123 - 4567 - 7899
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include('Phone number is invalid.')
      end

      it '都道府県が空だと登録できない' do
        @buyaddresses.prefecture_id = 1
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'tokenが空では登録できないこと' do
        @buyaddresses.token = nil
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では登録できないこと' do
        @buyaddresses.user_id = nil
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では登録できないこと' do
        @buyaddresses.item_id = nil
        @buyaddresses.valid?
        expect(@buyaddresses.errors.full_messages).to include("Item can't be blank")
      end

    end
  end
end
