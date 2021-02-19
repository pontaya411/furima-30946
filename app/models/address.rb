class Address < ApplicationRecord
  # 一つの購入記録に対して発送先は一つ。購入記録に対しての子の関係
  belongs_to :buy
end
