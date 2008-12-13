class CreateBpacks < ActiveRecord::Migration
  def self.up
    create_table :bpacks do |t|
      t.string :fullname
      t.string :email
      t.string :username
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :bpacks
  end
end
