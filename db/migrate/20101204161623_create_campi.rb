class CreateCampi < ActiveRecord::Migration
  def self.up
    create_table :campi do |t|
      t.string :nome

      t.timestamps
    end
  end

  def self.down
    drop_table :campi
  end
end
