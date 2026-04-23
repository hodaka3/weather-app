class City < ApplicationRecord
  belongs_to :prefecture
  has_many :weather_records, dependent: :destroy
end
