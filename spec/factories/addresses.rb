FactoryBot.define do
  factory :address do
    post_code { '123-4567' }
    city { '松戸市 ' }
    address_number { 3 }
    prefecture_id { 23 }

    association :buy
  end
end
