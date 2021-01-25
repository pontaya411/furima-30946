class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  # 下記、ActiveStorageを導入し、itemテーブルのレコードと画像を紐づけるためのメソッド記述
  has_one_attached :image
  
end
