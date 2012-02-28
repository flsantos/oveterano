class CreateOfertasReservasJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'ofertas_reservas', :id => false do |t|
      
      t.column :oferta_id, :integer
      t.column :reserva_id, :integer
      
      
      
    end 
  end

  def self.down
    drop_table :ofertas_reservas
  end
end
