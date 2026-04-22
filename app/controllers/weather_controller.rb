class WeatherController < ApplicationController
    def index
        # 10件だけ表示
        @weathers = WeatherRecord.order(:datetime).limit(20) 
    end
end