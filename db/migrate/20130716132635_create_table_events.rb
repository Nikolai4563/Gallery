class CreateTableEvents < ActiveRecord::Migration
  def up
    create_table :events do |event|
      event.integer :eventable_id
      event.string  :eventable_type
      event.integer :user_id
      event.datetime :created_at

    end
  end

  def down
    drop_table :events
  end
end
