class CreateOfertasProfessoresJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'ofertas_professores', :id => false do |t|
      
      t.column :oferta_id, :integer
      t.column :professor_id, :integer
      
      
      
    end  
  end

  def self.down
    drop_table :ofertas_professores
  end
end
