class AddDetailsToWeatherRecords < ActiveRecord::Migration[8.1]
  def change
    add_column :weather_records, :main, :string
    add_column :weather_records, :temp, :float
    add_column :weather_records, :humidity, :integer
  end
end
