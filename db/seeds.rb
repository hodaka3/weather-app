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
data = [
  {pref: "北海道", cities: [
    {name: "Sapporo", jp_name: "札幌"},
    {name: "Asahikawa", jp_name: "旭川"},
    {name: "Hakodate", jp_name: "函館"}
  ]},
  {pref: "青森県", cities: [
    {name: "Aomori", jp_name: "青森"},
    {name: "Hachinohe", jp_name: "八戸"},
    {name: "Towada", jp_name: "十和田"}
  ]},
  {pref: "岩手県", cities: [
    {name: "Morioka", jp_name: "盛岡"},
    {name: "Ichinoseki", jp_name: "一関"},
    {name: "Oshu", jp_name: "奥州"}
  ]},
  {pref: "宮城県", cities: [
    {name: "Sendai", jp_name: "仙台"},
    {name: "Ishinomaki", jp_name: "石巻"},
    {name: "Shiogama", jp_name: "塩釜"}
  ]},
  {pref: "秋田県", cities: [
    {name: "Akita", jp_name: "秋田"},
    {name: "Yokote", jp_name: "横手"},
    {name: "Oga", jp_name: "男鹿"}
  ]},
  {pref: "山形県", cities: [
    {name: "Yamagata", jp_name: "山形"},
    {name: "Tsuruoka", jp_name: "鶴岡"},
    {name: "Sakaiminato", jp_name: "酒田"}
  ]},
  {pref: "福島県", cities: [
    {name: "Fukushima", jp_name: "福島"},
    {name: "Koriyama", jp_name: "郡山"},
    {name: "Iwaki", jp_name: "いわき"}
  ]}
]

data.each do |d|
  prefecture = Prefecture.find_or_create_by!(name: d[:pref])
  d[:cities].each do |c|
    prefecture.cities.find_or_create_by!(name: c[:name]) do |city|
      city.jp_name = c[:jp_name]
    end
  end
end