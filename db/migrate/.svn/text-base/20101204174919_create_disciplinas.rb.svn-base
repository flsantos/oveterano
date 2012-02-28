class CreateDisciplinas < ActiveRecord::Migration
  def self.up
    create_table :disciplinas do |t|
      t.integer :codigo
      t.string :nome
      t.integer :departamento_id
      t.string :creditos
      #t.integer :votos_like, :null => false, :default => 0
      #t.integer :votos_dislike, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :disciplinas
  end
end
