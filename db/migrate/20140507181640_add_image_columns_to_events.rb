class AddImageColumnsToEvents < ActiveRecord::Migration
  def change
    add_attachment :events, :image
    add_column :events, :image_meta, :text
  end
end
