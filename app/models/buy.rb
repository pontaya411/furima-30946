class Buy < ApplicationRecord
  # usersが存在しなければ、購入履歴は存在しない
  belongs_to :user
  # temsが存在しなければ、購入履歴は存在できない
  belongs_to :item
  # itemが存在しなければ発送先は存在できない
  has_one :address
end
