class AddCityIdToWeatherRecords < ActiveRecord::Migration[8.1]
  def change
    add_reference :weather_records, :city, null: false, foreign_key: true
  end
end
