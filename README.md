# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## users table
|Column                |Type   |Options                      |
|----------------------|--------|----------------------------|
|nickname              |string  |null: false, unique: true   |
|email                 |string  |null: false, unique: true   |
|encrypted_password    |string  |null: false                 |
|is_deleted            |boolean |null: false, default: false |

### Association
- has_many: plans
- has_many: plan_likes
- has_many: pets
- has_many: hotel_likes
- has_many: hotels, through: :hotel_likes

## pets table
|Column                |Type        |Options                        |
|----------------------|------------|-------------------------------|
|name                  |string      |null: false                    |
|breed                 |string      |null: false                    |
|size_id               |integer     |null: false                    |
|user                  |references  |null: false, foreign_key:true  |

### Association
- belongs_to :user
- hos_many: plans


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
- belongs_to :pet
- hab_many :itineraries
- has_many :plan_likes
- has_many :plan_tags 
- has_many :tags, through: :plan_tags

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
|tag_name              |string      |null: false, unique:true |

### Association
- has_many :plan_tags
- has_many :plans, through: :plan_tags

## plan_likes table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|user                  |references  |null: false, foreign_key:true |
|plan                  |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :plan

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