class Size < ActiveHash::Base
  self.data = [
    {id: 1, name: '超小型犬'},
    {id: 2, name: '小型犬'},
    {id: 3, name: '中型犬'},
    {id: 4, name: '大型犬'}
  ]

  include ActiveHash::Associations
  has_many :users
end