require 'rest-client'
require 'json'

class WeatherRecord < ApplicationRecord
  def self.fetch_and_save
    # 環境変数からキーを取得
    api_key = ENV['OPENWEATHER_API_KEY']
    city = "Tokyo" # 好きな都市名に変えてOK
    url = "https://api.openweathermap.org/data/2.5/forecast?q=#{city}&appid=#{api_key}&units=metric"

    # API実行
    response = RestClient.get(url)
    data = JSON.parse(response.body)

    # 取得したリストをループしてDB保存
    data['list'].each do |forecast|
      # datetimeが同じデータがあれば更新、なければ新規作成（重複防止）
      record = self.find_or_initialize_by(datetime: Time.at(forecast['dt']))
      
      record.update(
        temperature: forecast.dig('main', 'temp'),
        wind_speed: forecast.dig('wind', 'speed'),
        # 降水量はデータがない場合があるので、なければ0を入れる
        precipitation: forecast.dig('rain', '3h') || 0
      )
    end
    puts "データの取得と保存が完了しました！"
  rescue => e
    puts "エラーが発生しました: #{e.message}"
  end
end