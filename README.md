# README
# PawfectTrip
愛犬との旅行記録アプリです。
ドッグフレンドリーな宿の検索や、他のユーザーの旅行日程の検索ができるため、次の旅行の計画立てに活用できます。

# URL
http://pawfect-trip.com/
画面右上の犬のアイコンから、メールアドレス・パスワード不要でゲストログインができます。

# 使用技術
- Ruby 3.2.0
- Ruby on Rails 7.0.7
- MySQL 8.0
- Nginx
- Puma
- AWS
  - VPC
  - EC2
  - RDS
  - Route53
  - S3

- Capistrano3
- RSpec
- Google Maps API
- Rakuten Travel API

# 機能一覧
- ユーザー管理機能(devise)
  - サインイン/サインアウト
  - ログアウト
  - ゲストログイン
  - 退会
  - マイページ機能
- 日程/行程登録機能
  - 投稿
  - 編集
  - 削除
- コメント機能
  - 投稿
  - 編集
  - 削除
- 検索機能
  - 宿泊先検索
  - 旅行日程検索
- いいね機能
  - 宿泊先・旅行日程のいいね登録
  - 宿泊先・旅行日程のいいね解除


# tables
## users table
|Column                |Type   |Options                      |
|----------------------|--------|----------------------------|
|nickname              |string  |null: false, unique: true   |
|email                 |string  |null: false, unique: true   |
|encrypted_password    |string  |null: false                 |
|is_deleted            |boolean |null: false, default: false |

### Association
- has_one: pet
- has_one: sns_credential
- has_many: plan_likes
- has_many: plans, through: :plan_likes
- has_many: hotel_likes
- has_many: hotels, through: :hotel_likes
- has_many: comments

## pets table
|Column                |Type        |Options                        |
|----------------------|------------|-------------------------------|
|name                  |string      |null: false                    |
|breed                 |string      |null: false                    |
|size_id               |integer     |null: false                    |
|user                  |references  |null: false, foreign_key:true  |

### Association
- belongs_to: user

## sns_credentials table
|Column                |Type        |Options                        |
|----------------------|------------|-------------------------------|
|provider              |string      |                               |
|uid                   |string      |                               |
|user                  |references  |null: false, foreign_key:true  |

### Association
- belongs_to :user

# plans table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|title                 |string      |null: false                   |
|departure_date        |datetime    |null: false                   |
|return_date           |datetime    |null: false                   |
|departure_id          |integer     |null: false                   |
|destination_id        |integer     |null: false                   |
|companion_id          |integer     |null: false                   |
|pet                   |references  |null: false, foreign_key:true |
|user                  |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- has_many :itineraries
- has_many :plan_likes
- has_many :plan_tags 
- has_many :tags, through: :plan_tags
- has_many :comments

## plan_likes table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|user                  |references  |null: false, foreign_key:true |
|plan                  |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :plan

# itineraries table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|date                  |datetime    |null: false                   |
|place                 |string      |null: false                   |
|transportation_id     |integer     |null: false                   |
|memo                  |text        |                              |
|plan                  |references  |null: false, foreign_key: true|

### Association
- belongs_to :plan

## plan_tags table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|tag                   |references  |null: false, foreign_key:true |
|plan                  |references  |null: false, foreign_key:true |

### Association
- belongs_to :tag
- belongs_to :plan

## tags table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|tag_name              |string      |null: false, unique:true      |

### Association
- has_many :plan_tags
- has_many :plans, through: :plan_tags

## hotels table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|hotel_num             |integer     |null: false                   |

### Association
- has_many :hotel_likes
- has_many :users, through: :hotel_likes

## hotel_likes table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|user                  |references  |null: false, foreign_key:true |
|hotel                 |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :hotel

## comments table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|comment               |text        |null: false                   |
|user                  |references  |null: false, foreign_key:true |
|plan                  |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :plan