# 日本全国の天気予報アプリ

https://weather-app-7mhq.onrender.com

地図上で選択した都市の天気予報をみることができるアプリケーションです。

地図表示機能: Leafletを使用し、全国の主要都市を地図上にプロット。

現在地の天気取得: OpenWeatherMap APIからリアルタイムの天気を取得。

多言語化対応: Google Geocoding APIを活用し、英語の都市データを日本語に変換。

データベースは表示する都市のリストやその都市の天気予報の保存に使用しています。

◎使用技術（技術スタック）

バックエンド: Ruby 4.0.2 / Ruby on Rails 8.1.3

データベース: PostgreSQL (Render) / SQLite3 (Local)

フロントエンド: JavaScript (Leaflet.js)

外部API: OpenWeatherMap API / Google Maps Geocoding API
