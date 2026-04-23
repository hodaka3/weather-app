require 'json'

namespace :import do
  desc "OpenWeather JSONから日本の全都市をインポート"
  task jpn_cities: :environment do
    file_path = Rails.root.join('db', 'city.list.json')
    
    unless File.exist?(file_path)
      puts "エラー: db/city.list.json が見つかりません。"
      next
    end

    puts "JSONファイルを読み込み中..."
    raw_data = File.read(file_path)
    all_cities = JSON.parse(raw_data)

    # 日本の都市だけを抽出
    jp_cities = all_cities.select { |c| c['country'] == 'JP' }
    puts "#{jp_cities.count} 件の日本都市を登録します..."

    # デフォルトの都道府県を用意
    default_pref = Prefecture.find_or_create_by!(name: "全国")

    # 高速化のためトランザクションを使用
    ActiveRecord::Base.transaction do
      jp_cities.each_with_index do |data, index|
        # 既存の都市名＋緯度経度で重複チェック
        City.find_or_create_by!(
          name: data['name'],
          latitude: data['coord']['lat'],
          longitude: data['coord']['lon']
        ) do |c|
          c.jp_name = data['name'] # JSONに日本語名がないため一旦英語名
          c.prefecture = default_pref
        end
        
        print "." if (index % 100).zero?
      end
    end

    puts "\n完了しました！"
  end
end