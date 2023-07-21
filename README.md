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
|password_confirmation |string  |null: false                 |
|is_deleted            |boolean |null: false, default: false |

### Association
- has_many: plans
- has_many: pets
- has_many: plan_favorites
- has_many: place_favorites

## pets table
|Column                |Type        |Options                        |
|----------------------|------------|-------------------------------|
|name                  |string      |null: false                    |
|breed                 |string      |null: false                    |
|size_id               |integer     |null: false                    |
|birthday              |date        |                               |
|user                  |references  |null: false, foreign_key:true  |

### Association
- belongs_to :user


# plans table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|title                 |string      |null: false                   |
|departure_date        |date        |null: false                   |
|destination_date      |date        |null: false                   |
|departure_id          |date        |null: false                   |
|destination_id        |date        |null: false                   |
|companion_id          |integer     |null: false                   |
|dog_id                |references  |null: false                   |
|tag_id                |references  |                              |
|user_id               |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- has_many :plan_favorites
- has_many :plan_tags 
- has_many :tags, through: :plan_tags

# itineraries table
|Column                |Type    |Options                          |
|----------------------|------------|-----------------------------|
|date                  |date        |null: false                  |
|time                  |time        |null: false                  |
|place                 |string      |null: false                  |
|transportation_id     |integer     |null: false                  |
|memo                  |text        |                             |

### Association
- belongs_to :plan

## plan_tags table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|tag_id                |references  |null: false, foreign_key:true |
|plan_id               |references  |null: false, foreign_key:true |

### Association
- belongs_to :tag
- belongs_to :plan

## tags table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|tag_name              |string      |null: false, unique:true |

### Association
- has_many :plans 
- has_many :plans, through: :plan_tags


## places table
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|name                  |string      |null: false                   |
|address               |string      |null: false                   |

### Association
- has_many :place_favorites

## plan_favorites table 
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|user_id               |references  |null: false, foreign_key:true |
|plan_id               |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :plan


## place_favorites
|Column                |Type    |Options                           |
|----------------------|------------|------------------------------|
|user_id               |references  |null: false, foreign_key:true |
|place_id              |references  |null: false, foreign_key:true |

### Association
- belongs_to :user
- belongs_to :place