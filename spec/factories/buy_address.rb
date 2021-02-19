FactoryBot.define do
  factory :buy_address do
    post_code { '123-4567' }
    city { '松戸市 ' }
    address_number { 3 }
    prefecture_id { 23 }
    building_name { 'ファミール' }
    phone_number { 12_345_678_999 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
