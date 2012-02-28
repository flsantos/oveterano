class CreateHorarios < ActiveRecord::Migration
  def self.up
    create_table :horarios do |t|
      t.integer :dia
      t.string :horario_ini
      t.string :horario_fim

      t.timestamps
    end
  end

  def self.down
    drop_table :horarios
  end
end
