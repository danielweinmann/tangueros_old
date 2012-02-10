class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :facebook_id, unique: true
      t.text :name
      t.references :event_type
      t.timestamp :start_time
      t.timestamp :end_time
      t.text :location
      t.text :picture

      t.timestamps
    end
    add_index :events, :event_type_id
  end
end
