class ChangePhotoAlbumRefToOptional < ActiveRecord::Migration[7.1]
  def change
    change_column :photos, :album_id, :bigint, null: true
  end
end
