class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :image_url, null: false
      t.string :description
      t.string :title
      t.references :album, null: false, foreign_key: true
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
