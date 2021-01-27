class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  # 下記、ActiveStorageを導入し、itemテーブルのレコードと画像を紐づけるためのメソッド記述
  has_one_attached :image

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
