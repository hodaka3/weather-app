class WeatherController < ApplicationController
  # コントローラー側の書き方例
  def index
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
end