# config/initializers/geocoder.rb
Geocoder.configure(
  lookup: :google,
  api_key: ENV["GOOGLE_MAPS_API_KEY"], # ここを書き換える
  language: :ja,
  units: :km
)