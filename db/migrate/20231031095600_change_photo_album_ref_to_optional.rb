class ChangePhotoAlbumRefToOptional < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:photos, :album_id, false)
  end

  # def down
  #   change_column :photos, :album_id, :bigint, null: false
  # end
  #
  # def up
  #   change_column :photos, :album_id, :bigint, null: true
  # end
end
