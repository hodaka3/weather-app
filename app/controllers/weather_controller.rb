class WeatherController < ApplicationController
  def index
    # データが1件もなければ、その場で取得を実行する
    if WeatherRecord.count == 0
      WeatherRecord.fetch_and_save
    end

    @weathers = WeatherRecord.order(datetime: :desc).limit(20)
  end
end