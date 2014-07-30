class CreateIlohvNodes < ActiveRecord::Migration
  def change
    create_table :ilohv_nodes do |t|
      t.string :type

      t.string :name
      t.text :full_path

      t.text :ancestry

      t.timestamps
    end

    add_index :ilohv_nodes, :name
    add_index :ilohv_nodes, :full_path
    add_index :ilohv_nodes, :ancestry
  end
end
