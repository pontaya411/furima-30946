class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  # 下記、ActiveStorageを導入し、itemテーブルのレコードと画像を紐づけるためのメソッド記述
  has_one_attached :image


  # 商品名（name)と商品の説明(subscription)は必須であることのバリデーション
  # with_options presence: true
  validates :image, presence: true
  validates :name, presence: true
  validates :subscription, presence: true
  validates :price, presence: true
  # validates :price, format: {with: less_than_or_equal_to: 300, greater_than_or_equal_to: 9,999,999, message: "out of range"}
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" }
  # ３００円以上９９９万円以下のバリデーション。numericalityは半角数字を許可します。

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
