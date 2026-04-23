class AddCityIdToWeatherRecords < ActiveRecord::Migration[7.0]
  def change
    # 1. まずは null: true (空OK) でカラムを追加する
    add_reference :weather_records, :city, null: true, foreign_key: true

    # 2. すでにある古いデータを削除するか、適当な都市を割り当てる
    # (本番の古いデータが不要なら削除するのが一番早いです)
    reversible do |dir|
      dir.up do
        execute "DELETE FROM weather_records" 
      end
    end

    # 3. データが空になったので、改めて null: false 制約をつける
    change_column_null :weather_records, :city_id, false
  end
end