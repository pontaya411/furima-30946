# README

## usersテーブル

| Column             | Type   | Option
|--------------------|--------|-------------|
| nickname           | string | null :false |
| last_name          | string | null :false |
| first_name         | string | null :false |
| last_name_kana     | string | null :false |
| first_name_kana    | string | null :false |
| email              | string | null :false |
| encrypted_password | string | null :false |
| birthday           | string | null :false |

### Association

<!-- 一人のuserは一つでも二つでも商品を購入できるため -->
- has_many :items
<!-- 一人のuserは商品を購入した記録が複数あるため -->
- has_many :buys

<!-- 商品情報を保存するテーブル -->
## items テーブル

| Column       | Type       | Option            |
|---------------|------------|-------------------|
| name          | string     | null :false       |
| subscription  | text       | null :false       |
| status_id     | integer    | null :false       |
| category_ud   | integer    | null :false       |
| price         | integer    | null :false       |
| ship_fee_id   | integer    | null :false       |
| ship_date_id  | integer    | null :false       |
| prefecture_id | integer    | null :false       |
| user          | references | foreign_key :true |

### Association

<!-- has_manyのassociationに対してitemsテーブルはusersテーブルに対して子の関係になる -->
- belongs_to :user
<!-- 一つのitemが持つ購入記録は一つだけ。購入履歴にとっての親 -->
- has_one :buy

<!-- 購入記録を保存するテーブル -->
## buys テーブル

| Column   | Type       | Option            |
|----------|------------|-------------------|
| user     | references | foreign_key :true |
| item     | references | foreign_kry :true |

### Association

<!-- usersが存在しなければ、購入履歴は存在しない -->
- belongs_to :user
<!-- itemsが存在しなければ、購入履歴は存在できない -->
- belongs_to :item
<!-- itemが存在しなければ発送先は存在できない -->
- has_one :address

<!-- 発送先を保存するテーブル -->
## addresses テーブル

| Column         | Type       | Option           |
|----------------|------------|------------------|
| post_code      | string     | null :false      |
| prefecture_id  | integer    | null :false      |
| city           | string     | null :false      |
| address_number | string     | null :false      |
| building_name  | string     |
| phone_number   | string     | null :false      |
| buy            | references | foreign_key :true|
 
## Association

<!-- 一つの購入記録に対して発送先は一つ。購入記録に対しての子の関係 -->
- belongs_to :buy