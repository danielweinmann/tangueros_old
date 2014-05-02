class SetPermalinkOnEvents < ActiveRecord::Migration
  def up
    execute("UPDATE events SET permalink = name")
  end
  def down
    execute("UPDATE posts SET permalink = null")
  end
end
