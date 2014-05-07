class RemoveOldColumnsFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :picture
    remove_column :events, :picture_width
    remove_column :events, :picture_height
  end
end
