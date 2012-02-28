class CreateDisciplinasFluxosJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'disciplinas_fluxos', :id => false do |t|
      t.column :fluxo_id, :integer
      t.column :disciplina_id, :integer
    end
  end

  def self.down
    drop_table :disciplinas_fluxos
  end
end
