class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps
    end

    add_index :projects, :name
    add_attachment :projects, :attachment
  end
end
