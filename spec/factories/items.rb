FactoryBot.define do
  factory :item do
    name { 'test' }
    subscription { 'test' }
    category_id { 3 }
    price        { 301 }
    ship_date_id { 2 }
    prefecture_id { 23 }
    ship_fee_id { 3 }
    status_id { 2 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
