class AddCoordinatesToCities < ActiveRecord::Migration[8.1]
  def change
    add_column :cities, :latitude, :float
    add_column :cities, :longitude, :float
  end
end
