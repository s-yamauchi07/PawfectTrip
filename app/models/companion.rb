class Companion < ActiveHash::Base
  self.data = [
    {id: 1, name: '無し(一人)'},
    {id: 2, name: '友人'},
    {id: 3, name: '夫婦・パートナー'},
    {id: 4, name: '家族(子連れ)'},
    {id: 5, name: 'その他'},
  ]

  include ActiveHash::Associations
  has_many :plans
end