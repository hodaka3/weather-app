class CreateWeatherRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :weather_records do |t|
      t.datetime :datetime
      t.float :temperature
      t.float :wind_speed
      t.float :precipitation

      t.timestamps
    end
  end
end
