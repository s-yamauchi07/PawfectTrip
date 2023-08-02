class Transportation < ActiveHash::Base
  self.data = [
    {id: 1, name: '徒歩'},
    {id: 2, name: '自転車'},
    {id: 3, name: '車'},
    {id: 4, name: '電車'},
    {id: 5, name: '飛行機'},
    {id: 6, name: '船'},
  ]

  include ActiveHash::Associations
  has_many :inineraries
end