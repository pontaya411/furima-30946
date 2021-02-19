class BuyAddress
  include ActiveModel::Model
  attr_accessor :prefecture_id, :post_code, :city, :address_number, :building_name, :phone_number, :item_id, :token, :user_id

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-).' }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters.' }
    validates :address_number
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/, message: 'is invalid.' }
    validates :token
    validates :prefecture_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'must be other than 1' }

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address_number: address_number,
                   building_name: building_name, phone_number: phone_number, buy_id: buy.id)
  end
end
