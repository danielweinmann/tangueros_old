class AddPictureWidthAndPictureHeightToEvent < ActiveRecord::Migration
  def change
    add_column :events, :picture_width, :integer
    add_column :events, :picture_height, :integer
  end
end
