# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 都道府県の登録
# 緯度・経度付きのデータ
cities_data = [
  { name: "Tokyo", jp_name: "東京", lat: 35.6895, lon: 139.6917 },
  { name: "Osaka", jp_name: "大阪", lat: 34.6937, lon: 135.5023 },
  { name: "Sapporo", jp_name: "札幌", lat: 43.0621, lon: 141.3544 }
  # ... 他の都市も同様に lat, lon を追加
]

cities_data.each do |data|
  # 都道府県は適宜調整してください
  pref = Prefecture.first 
  City.find_or_create_by!(name: data[:name]) do |c|
    c.jp_name = data[:jp_name]
    c.latitude = data[:lat]
    c.longitude = data[:lon]
    c.prefecture = pref
  end
end