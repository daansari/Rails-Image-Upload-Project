class AddLocationAndTimestampToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :p_latitude, :float
    add_column :projects, :p_longitude, :float
    add_column :projects, :p_timestamp, :datetime
  end
end
