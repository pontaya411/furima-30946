require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
    # @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品出品機能' do
    context '商品出品がうまくいくとき' do
      it '全ての情報が入力されていれば出品できる' do
        expect(@item).to be_valid
        #  expect(@item.valid?).to eq true
      end
    end

    context '商品出品がうまくいかないとき' do
      it '商品画像を一枚ついていないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明がないと出品できない' do
        @item.subscription = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Subscription can't be blank")
      end

      it 'カテゴリーの情報が選択されていないと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end

      it '商品の状態ついて選択されていないと出品できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Status is not a number')
      end

      it '配送料補負担が情報が選択されていないと出品できない' do
        @item.ship_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship fee is not a number')
      end

      it '発送元の地域が選択されていないと出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture is not a number')
      end

      it '価格が入力されていないと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格の範囲が¥300以下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '価格の範囲が¥9,999,999以上では出品できない' do
        @item.price = 10, 0o00, 0o00
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
