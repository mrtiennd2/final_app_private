class AddUserRefToPhoto < ActiveRecord::Migration[7.1]
  def change
    add_reference :photos, :user, null: false, foreign_key: true
  end
end
