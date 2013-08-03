class AddIndex < ActiveRecord::Migration
  def up
    add_index :images, :category_id
    add_index :events, [:eventable_id, :eventable_type]
    add_index :events, :user_id
    add_index :likes, [:user_id, :image_id]
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :image_id
    add_index :subscribes, [:user_id, :category_id]
  end

  def down
    remove_index :images, :category_id
    remove_index :events, [:eventable_id, :eventable_type, :user_id]
    remove_index :likes, [:user_id, :image_id]
    remove_index :comments, [:commentable_id, :commentable_type]
    remove_index :comments, :image_id
    remove_index :subscribes, [:user_id, :category_id]
  end
end
