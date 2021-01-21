FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'a00000' }
    password_confirmation { password }
    last_name             { '鈴川' }
    first_name            { '綾' }
    last_name_kana        { 'スズカワ' }
    first_name_kana       { 'アヤ' }
    birthday              { 19_850_411 }
  end
end
