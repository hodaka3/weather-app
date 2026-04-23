class AddIconToWeatherRecords < ActiveRecord::Migration[8.1]
  def change
    add_column :weather_records, :icon, :string
  end
end
