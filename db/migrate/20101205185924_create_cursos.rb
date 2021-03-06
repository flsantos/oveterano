class CreateCursos < ActiveRecord::Migration
  def self.up
    create_table :cursos do |t|
      t.integer :codigo
      t.string :nome
      t.string :modalidade
      t.string :turno
      t.integer :campus_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cursos
  end
end
