class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :cursos, :campus_id
    add_index :horarios_ofertas, [:oferta_id, :horario_id]
    add_index :horarios_ofertas, [:horario_id, :oferta_id]
    add_index :ofertas_reservas, [:reserva_id, :oferta_id]
    add_index :ofertas_reservas, [:oferta_id, :reserva_id]
    add_index :ofertas_professores, [:professor_id, :oferta_id]
    add_index :ofertas_professores, [:oferta_id, :professor_id]
    add_index :disciplinas_fluxos, [:fluxo_id, :disciplina_id]
    add_index :disciplinas_fluxos, [:disciplina_id, :fluxo_id]
    add_index :curriculos_disciplinas, [:disciplina_id, :curriculo_id]
    add_index :curriculos_disciplinas, [:curriculo_id, :disciplina_id]
    add_index :fluxos, :habilitacao_id
    add_index :habilitacoes, :curso_id
    add_index :campi_disciplinas, [:disciplina_id, :campus_id]
    add_index :campi_disciplinas, [:campus_id, :disciplina_id]
    add_index :disciplinas, :departamento_id
    add_index :posts, :alias_id
    add_index :posts, :autor_id
    add_index :habilitacoes, :curriculo_id
    add_index :habilitacoes, :fluxo_id
  end

  def self.down
    remove_index :curriculos, :habilitacao_id
    remove_index :cursos, :campus_id
    remove_index :horarios_ofertas, :column => [:oferta_id, :horario_id]
    remove_index :horarios_ofertas, :column => [:horario_id, :oferta_id]
    remove_index :ofertas_reservas, :column => [:reserva_id, :oferta_id]
    remove_index :ofertas_reservas, :column => [:oferta_id, :reserva_id]
    remove_index :ofertas_professores, :column => [:professor_id, :oferta_id]
    remove_index :ofertas_professores, :column => [:oferta_id, :professor_id]
    remove_index :disciplinas_fluxos, :coilumn => [:fluxo_id, :disciplina_id]
    remove_index :disciplinas_fluxos, :coilumn => [:disciplina_id, :fluxo_id]
    remove_index :curriculos_disciplinas, :column => [:disciplina_id, :curriculo_id]
    remove_index :curriculos_disciplinas, :column => [:curriculo_id, :disciplina_id]
    remove_index :fluxos, :habilitacao_id
    remove_index :habilitacoes, :curso_id
    remove_index :campi_disciplinas, :column => [:disciplina_id, :campus_id]
    remove_index :campi_disciplinas, :column => [:campus_id, :disciplina_id]
    remove_index :disciplinas, :departamento_id
    remove_index :posts, :alias_id
    remove_index :posts, :autor_id
    remove_index :habilitacoes, :curriculo_id
    remove_index :habilitacoes, :fluxo_id
  end
end
