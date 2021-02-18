class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :post_code,      default: "",  null: false
      t.integer :prefecture_id,               null: false
      t.string :city,           default: ""
      t.string :phone_number,   default: ""
      t.string :building_name,  default: ""
      t.string :address_number, null: false
      t.references :buy,                     null: false,  foreign_key: true

      t.timestamps
    end
  end
end
