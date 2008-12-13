class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.string :file_name
      t.string :description
      t.integer :belonging_id

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
