class CreateCampiDisciplinasJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'campi_disciplinas', :id => false do |t|
      t.column :campus_id, :integer
      t.column :disciplina_id, :integer
      
      
    end
  end

  def self.down
    drop_table :campi_disciplinas
  end
end
