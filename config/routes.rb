Rails.application.routes.draw do
  get 'admin/fix_db', to: 'weather#fix_database'
  root 'weather#index' # サイトのトップページを天気一覧にする
end