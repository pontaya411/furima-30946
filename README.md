# README

## usersテーブル


| Column         | Type    | Option
|-----------     |---------|--------------------|
| nickname       | string  | null:   false      |
| last_name      | string  | null:   false      |
| first_name     | string  | null:   false      |
| last_name_kana | string  | null:   false      |
| first_name_kana| string  | null:   false      |
| email          | string  | null:   false      |
| password       | string  | encrypted_password |

### Association


<!-- 一人のuserは一つでも二つでも商品を購入できるため -->
- has_many :items
<!-- 一人のuserは商品を購入した記録が複数あるため -->
- has_many :buys
<!-- 一人のuserに対して住所は一つ。addressesテーブルはuserテーブルがないと成り立たない -->
- has_one  :addresses

<!-- 商品情報を保存するテーブル -->
## items テーブル

* Database initialization
| Column            | Type       | Option            |
|-------------------|------------|-------------------|
| item_name         | string     | null :false       |
| item_subscription | text       | null :false       |
| item_status       | integer    | # ActiveHushで実装 |
| item_category     | integer    |# ActiveHushで実装  |
| item_price        | integer    | null :false       |
| ship_fee          | integer    | # ActiveHushで実装 |
| ship_date         | integer    | # ActiveHushで実装 |
| ship_from         | integer    | # ActiveHushで実装 |
| user              | references | foreign_key :true |

### Association

<!-- has_manyのassociationに対してitemsテーブルはusersテーブルに対して子の関係になる -->
- belongs_to :users
<!-- 一つのitemが持つ購入記録は一つだけ。購入履歴にとっての親 -->
- has_one :buys
<!-- 一つのitemに対して発送先は一つだけ。発送先にとっての親 -->
- has_one :addresses

<!-- 購入記録を保存するテーブル -->
## buys テーブル

| Column   | Type       | Option            |
|----------|------------|-------------------|
| user     | references | foreign_key :true |
| item     | references | foreign_kry :true |

### Association

<!-- usersが存在しなければ、購入履歴は存在しない -->
- belongs_to :users
<!-- itemsが存在しなければ、購入履歴は存在できない -->
- belongs_to :items

<!-- 発送先を保存するテーブル -->
## addresses テーブル

| Column         | Type       | Option            |
|----------------|------------|-------------------|
| post_code      | integer    | # ActiveHushで実装 |
| prefecture     | integer    | # ActiveHushで実装 |
| city           | string     | null :false       |
| address_number | integer    | null :false       |
| building_name  | string     |
| phone_number   | integer    | null :false       |
| user           | references | foreign_key       |   
 
## Association

<!-- 一つの購入記録に対して発送先は一つ。購入記録に対しての子の関係 -->
- belongs_to :buys