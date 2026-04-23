class WeatherController < ApplicationController
  # コントローラー側の書き方例
  def index
    @all_cities = City.select(:id, :jp_name, :latitude, :longitude)

    if params[:city_id].present?
      @city = City.find(params[:city_id])
      
      # データが古い、または無い場合に取得
      # 5日分の予報が入るので、最新の1件が現在より過去なら更新、といった使い方もできます
      if @city.weather_records.empty?
        WeatherRecord.fetch_and_save(@city)
      end
      
      @weathers = @city.weather_records
      .where("datetime >= ?", Time.current)
      .order(datetime: :asc)
      .limit(20)
    end
  end

  def fix_database
    # Threadを使わずに直接実行
    puts "--- [DEBUG] 処理を開始します ---"
    
    # 1. 掃除の順番を修正（子を先に消す）
    puts "--- [DEBUG] お天気データを削除中 ---"
    WeatherRecord.delete_all # もしモデル名が違う場合は修正してください
    
    puts "--- [DEBUG] 都市データを削除中 ---"
    City.delete_all
    
    # 2. シード読み込み
    seed_file = Rails.root.join('db', 'seeds.rb')
    if File.exist?(seed_file)
      puts "--- [DEBUG] seeds.rbを読み込みます ---"
      load seed_file
      puts "--- [DEBUG] 全工程完了 ---"
      msg = "成功しました！重複が解消され、1401件のデータが再作成されました。"
    else
      msg = "seeds.rbが見つかりませんでした。"
    end

    render plain: msg
  rescue => e
    puts "--- [DEBUG] エラー発生: #{e.message} ---"
    render plain: "エラー: #{e.message}"
  end

end