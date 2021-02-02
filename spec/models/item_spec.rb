require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
    # ActiveStorageのテストに下記の記述が必要な時がある（メンターに教えてもらった。後でもしかすると参照するかもしれない）
    # @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品出品機能' do
    context '商品出品がうまくいくとき' do
      it '全ての情報が入力されていれば出品できる' do
        expect(@item).to be_valid
        # 上記と同じ内容だが記述が違う。参照用
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
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it '商品の状態ついて選択されていないと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end

      it '配送料補負担が情報が選択されていないと出品できない' do
        @item.ship_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship fee must be other than 1')
      end

      it '発送までの日数が選択されていないと出品できない' do
        @item.ship_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship date must be other than 1')
      end

      it '発送元の地域が選択されていないと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
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
        @item.price = 10, 000, 0o00
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '価格が全角文字では登録できないこと' do
        @item.price = "６００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range", "Price is invalid. Input half-width characters.")
      end
        it '価格が英数混合では登録できないこと' do
        @item.price = "10a"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range", "Price is invalid. Input half-width characters.")
      end

      it '価格が半角英語のみでは登録できないこと' do
        @item.price = "abc"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range", "Price is invalid. Input half-width characters.")
      end

    end
  end
end