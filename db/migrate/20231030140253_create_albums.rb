class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :description
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
