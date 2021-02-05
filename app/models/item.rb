class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  # 下記、ActiveStorageを導入し、itemテーブルのレコードと画像を紐づけるためのメソッド記述
  has_one_attached :image

  # 空欄では登録できないバリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :subscription
    validates :price
  end

  # ３００円以上９９９万円以下のバリデーション。numericalityは半角数字を許可します。
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  # 半角数字だけを許可するバリデーション
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters.' }

  # ActiveHashに下記のカラムが紐づいている
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status
  belongs_to :category
  belongs_to :ship_fee
  belongs_to :ship_date
  belongs_to :prefecture

  # with_optionsでバリデーションをまとめる。ジャンルの選択が「--」(id:1)の時は保存できないようにするバリデーション
  with_options numericality: { other_than: 1 } do
    validates :status_id
    validates :category_id
    validates :ship_fee_id
    validates :ship_date_id
    validates :prefecture_id
  end
end
