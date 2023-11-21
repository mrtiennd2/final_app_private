class ChangeUserIdNullTrue < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:likes, :user_id, true)
  end

  # def down
  #   change_column :likes, :user_id, :integer, null: false
  # end
  #
  # def up
  #   change_column :likes, :user_id, :integer, null: true
  # end
end
