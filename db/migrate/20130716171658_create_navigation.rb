class CreateNavigation < ActiveRecord::Migration
  def up
    create_table :navigations do |column|
      column.string :path
      column.float :page_duration
      column.float :view_duration
      column.float :db_duration
    end
  end

  def down
    drop_table :navigations
  end
end
