class CreateTables < ActiveRecord::Migration
  def change

    create_table :likes do |like|
      like.integer  :user_id
      like.integer :image_id

    end


    create_table :comments do |comment|
      comment.integer :commentable_id
      comment.string  :commentable_type
      comment.integer :image_id
      comment.string  :body

      comment.timestamps

    end


    create_table :images do |img|
      img.integer :category_id
      img.integer :likes_count, :default => 0
      img.integer :comments_count, :default => 0
      img.string :url
    end

    create_table :categories do |cat|
      cat.integer :images_count, :default => 0
      cat.string :name, limit: 255

    end
    Category.reset_column_information
    Category.all.each do |category|
      Category.update_counters category.id, :images_count => category.images.length
    end
    Image.reset_column_information
    Image.all.each do |img|
      Image.update_counters img.id, :likes_count => img.likes.length
      Image.update_counters img.id, :comments_count => img.comments.length
    end
  end
end
