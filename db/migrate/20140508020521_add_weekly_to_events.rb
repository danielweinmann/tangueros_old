class AddWeeklyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :weekly, :boolean, null: false, default: false
  end
end
