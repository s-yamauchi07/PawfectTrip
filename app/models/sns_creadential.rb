class SnsCreadential < ApplicationRecord
  belongs_to :user, optional: true
end
