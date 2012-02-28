class CreateVotos < ActiveRecord::Migration
  def self.up
     create_table :votos do |t|
          t.integer :alias
          t.integer :alias_id
          t.integer :voto
          t.integer :autor_id
          
          t.timestamps
    end
  end

  def self.down
    drop_table :votos
  end
end
