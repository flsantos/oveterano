class CreateDepartamentos < ActiveRecord::Migration
  def self.up
    create_table :departamentos do |t|
      t.string :codigo
      t.string :sigla
      t.string :nome

      t.timestamps
    end
  end

  def self.down
    drop_table :departamentos
  end
end
