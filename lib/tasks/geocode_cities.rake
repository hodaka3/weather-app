namespace :cities do
  desc "Google Maps APIを使って日本語名と都道府県を一気に取得する（進捗表示付き）"
  task reverse_geocode: :environment do
    target_cities = City.where(jp_name: nil).or(City.where("jp_name = name"))
    total_count = target_cities.count
    
    if total_count == 0
      puts "処理対象の都市はありません。"
      next
    end

    puts "#{total_count} 件の処理を開始します（Google API使用）"
    puts "--------------------------------------------------"

    target_cities.find_each.with_index(1) do |city, index|
      begin
        # 進捗率の計算
        percent = ((index.to_f / total_count) * 100).round(1)
        
        # 逆ジオコーディング実行
        result = Geocoder.search([city.latitude, city.longitude]).first

        if result
          pref_name = result.state
          japanese_name = result.city || 
                (result.respond_to?(:sublocality) ? result.sublocality : nil) || 
                (result.respond_to?(:ward) ? result.ward : nil) ||
                result.address_components.find { |c| c['types'].include?('locality') }&.dig('long_name')
          
          if pref_name.present?
            prefecture = Prefecture.find_or_create_by!(name: pref_name)
            city.update!(
              jp_name: japanese_name || city.name,
              prefecture: prefecture
            )
            # 進捗を一行で上書き表示（\r を使うのがコツです）
            print "\r[#{index}/#{total_count}] #{percent}% 完了 - 現在: #{pref_name} #{japanese_name}          "
          end
        end

        sleep 0.1 

      rescue => e
        puts "\nエラー (#{city.name}): #{e.message}"
        if e.message.include?("OVER_QUERY_LIMIT")
          puts "API制限に達しました。"
          break
        end
      end
    end
    
    puts "\n--------------------------------------------------"
    puts "すべての処理が完了しました！"
  end
end