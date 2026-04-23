class CreateCities < ActiveRecord::Migration[8.1]
  def change
    create_table :cities do |t|
      t.references :prefecture, null: false, foreign_key: true
      t.string :name
      t.string :jp_name

      t.timestamps
    end
  end
end
