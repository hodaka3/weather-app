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
    # 1. データの全削除（重複を解消）
    City.delete_all
    # 都道府県も重複している可能性がある場合は、以下もコメントアウトを外す
    # Prefecture.delete_all

    # 2. 1401件のシードを「バックグラウンド」で実行
    # Thread.new を使うことで、ブラウザ側のタイムアウトを防ぎつつ、
    # サーバー内部でゆっくりとデータを投入させます。
    Thread.new do
      Rails.application.load_seed
    end

    render plain: "データベースの掃除を完了し、バックグラウンドでシードを開始しました。5分ほどでピンが正しく表示されます。RenderのLogsを確認してください。"
  end

end