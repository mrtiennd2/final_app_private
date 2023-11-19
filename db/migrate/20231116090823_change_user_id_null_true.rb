class ChangeUserIdNullTrue < ActiveRecord::Migration[7.1]
  def change
    change_column :likes, :user_id, :integer, null: true
  end
end
