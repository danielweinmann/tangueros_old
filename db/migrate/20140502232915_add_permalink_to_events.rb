class AddPermalinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :permalink, :string
  end
end
