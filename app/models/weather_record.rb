require 'rest-client'
require 'json'

class WeatherRecord < ApplicationRecord
  belongs_to :city

  WEATHER_MAP = {
    "Clear" => "晴れ",
    "Clouds" => "曇り",
    "Rain" => "雨",
    "Snow" => "雪",
    "Thunderstorm" => "雷雨",
    "Drizzle" => "霧雨",
    "Mist" => "霧"
  }

  def main_jp
    WEATHER_MAP[main] || main
  end

  def self.fetch_and_save(city)
    # 環境変数からキーを取得
    api_key = ENV['OPENWEATHER_API_KEY']
    # 5日間/3時間ごとの予報APIを使用
    encoded_city_name = URI.encode_www_form_component("#{city.name},JP")
    url = "https://api.openweathermap.org/data/2.5/forecast?q=#{encoded_city_name}&appid=#{api_key}&units=metric&lang=ja"

    # API実行
    response = RestClient.get(url)
    data = JSON.parse(response.body)

    # 取得したリストをループしてDB保存
    data['list'].each do |forecast|
      # 「同じ都市」かつ「同じ日時」のデータがあればそれを使い、なければ新しく作る
      record = self.find_or_initialize_by(
        city: city,
        datetime: Time.at(forecast['dt'])
      )
      
      # カラム名を現在のテーブル構成（main, temp, humidity）に合わせて更新
      record.update!(
        main: forecast.dig('weather', 0, 'main'), # 天気状態 (Rain, Cloudsなど)
        temp: forecast.dig('main', 'temp'),       # 気温
        humidity: forecast.dig('main', 'humidity'), # 湿度
        icon: forecast.dig('weather', 0, 'icon')   # 天気アイコンのID
      )
    end
    puts "#{city.jp_name} のデータの取得と保存が完了しました！"
  rescue => e
    puts "エラーが発生しました: #{e.message}"
  end
end