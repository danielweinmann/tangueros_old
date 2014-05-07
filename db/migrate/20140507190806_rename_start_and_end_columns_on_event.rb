class RenameStartAndEndColumnsOnEvent < ActiveRecord::Migration
  def change
    rename_column :events, :start_time, :starts_at
    rename_column :events, :end_time, :ends_at
  end
end
