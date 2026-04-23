class AddCityIdToWeatherRecords < ActiveRecord::Migration[7.0]
  def up
    # 1. もし既に中途半端にカラムが存在していたら削除（エラー回避の安全策）
    if column_exists?(:weather_records, :city_id)
      remove_reference :weather_records, :city, foreign_key: true
    end

    # 2. 原因となる古い「履歴データ」をテーブルから完全に消去
    execute "TRUNCATE TABLE weather_records RESTART IDENTITY CASCADE"

    # 3. テーブルが空になったので、正しい制約でカラムを追加
    add_reference :weather_records, :city, null: false, foreign_key: true
  end

  def down
    remove_reference :weather_records, :city
  end
end