class CreatePrefectures < ActiveRecord::Migration[8.1]
  def change
    create_table :prefectures do |t|
      t.string :name

      t.timestamps
    end
  end
end
