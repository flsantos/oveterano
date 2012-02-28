class CreateCurriculosDisciplinasJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'curriculos_disciplinas', :id => false do |t|
      t.column :curriculo_id, :integer
      t.column :disciplina_id, :integer
    end
  end

  def self.down
    drop_table :curriculos_disciplinas
  end
end
