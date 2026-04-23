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
    # 掃除とシードをバックグラウンドで実行
    Thread.new do
      # RailsのActiveRecordをスレッド内で安全に使うための設定
      ActiveRecord::Base.connection_pool.with_connection do
        begin
          puts "--- データ掃除開始 ---"
          City.delete_all
          
          puts "--- シード開始 ---"
          # seeds.rb を直接読み込む
          load Rails.root.join('db', 'seeds.rb')
          
          puts "--- すべての工程が完了しました ---"
        rescue => e
          puts "エラーが発生しました: #{e.message}"
        end
      end
    end

    render plain: "処理を受け付けました。RenderのLogsを確認してください。"
  rescue => e
    render plain: "エラーが発生しました: #{e.message}", status: 500
  end

end