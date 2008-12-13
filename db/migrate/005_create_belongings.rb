class CreateBelongings < ActiveRecord::Migration
  def self.up
    create_table :belongings do |t|
      t.string :name
      t.integer :page_id
      t.integer :position
      t.string :widget_type

      t.timestamps
    end
  end

  def self.down
    drop_table :belongings
  end
end
