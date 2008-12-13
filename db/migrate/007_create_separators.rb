class CreateSeparators < ActiveRecord::Migration
  def self.up
    create_table :separators do |t|
      t.string :title
      t.integer :belonging_id

      t.timestamps
    end
  end

  def self.down
    drop_table :separators
  end
end
