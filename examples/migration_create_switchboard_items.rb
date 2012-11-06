class CreateSwitchboardItems < ActiveRecord::Migration
  def change
    create_table :switchboard_items do |t|
      t.integer :switchboard_id
      t.integer :item_number
      t.string :item_text, :limit => 255
      t.integer :command
      t.string :argument, :limit => 50
    end

    add_index :switchboard_items, :switchboard_id
  end
end
