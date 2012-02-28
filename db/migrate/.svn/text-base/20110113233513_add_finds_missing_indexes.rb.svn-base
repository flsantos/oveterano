class AddFindsMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :votos, :id
    add_index :curriculos, :id
    add_index :cursos, :id
    add_index :habilitacoes, :id
    add_index :fluxos, :id
    add_index :departamentos, :id
    add_index :usuarios, :id
    add_index :posts, :id
    add_index :campi, :id
    add_index :reservas, :id
    add_index :reservas, :curso
    add_index :professores, :id
    add_index :professores, :nome
    add_index :ofertas, :id
    add_index :ofertas, [:id, :disciplina_id]
    add_index :ofertas, [:disciplina_id, :id]
    add_index :disciplinas, :id
    add_index :horarios, :id
  end

  def self.down
    remove_index :votos, :id
    remove_index :curriculos, :id
    remove_index :cursos, :id
    remove_index :habilitacoes, :id
    remove_index :fluxos, :id
    remove_index :departamentos, :id
    remove_index :usuarios, :id
    remove_index :posts, :id
    remove_index :campi, :id
    remove_index :reservas, :id
    remove_index :reservas, :curso
    remove_index :professores, :id
    remove_index :professores, :nome
    remove_index :ofertas, :id
    remove_index :ofertas, :column => [:id, :disciplina_id]
    remove_index :ofertas, :column => [:disciplina_id, :id]
    remove_index :disciplinas, :id
    remove_index :horarios, :id
  end
end
