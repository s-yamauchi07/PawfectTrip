class Transportation < ActiveHash::Base
  self.data = [
    {id: 1, name: '徒歩', image: "walk.png"},
    {id: 2, name: '自転車',image: "bicycle.png"},
    {id: 3, name: '車',image: "car.png"},
    {id: 4, name: '電車',image: "train.png"},
    {id: 5, name: '飛行機',image: "airplain.png"},
    {id: 6, name: '船',image: "ship.png"},
  ]

  include ActiveHash::Associations
  has_many :inineraries
end