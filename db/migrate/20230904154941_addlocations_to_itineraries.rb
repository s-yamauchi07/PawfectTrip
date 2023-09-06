class AddlocationsToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :lat, :float
    add_column :itineraries, :lng, :float
  end
end
