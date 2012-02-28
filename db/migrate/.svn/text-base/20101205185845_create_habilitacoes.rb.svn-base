class CreateHabilitacoes < ActiveRecord::Migration
  def self.up
    create_table :habilitacoes do |t|
      t.integer :codigo
      t.string :nome
      t.integer :curso_id
      t.integer :fluxo_id
      t.integer :curriculo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :habilitacoes
  end
end
