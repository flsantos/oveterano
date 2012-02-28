class CreateHorariosOfertasJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'horarios_ofertas', :id => false do |t|
      
      t.column :horario_id, :integer
      t.column :oferta_id, :integer
      
      
      
    end 
  end

  def self.down
    drop_table :horarios_ofertas
  end
end
