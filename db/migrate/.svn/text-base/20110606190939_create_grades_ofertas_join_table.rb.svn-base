class CreateGradesOfertasJoinTable < ActiveRecord::Migration
  def self.up
    create_table 'grades_ofertas', :id => false do |t|
      
      t.column :oferta_id, :integer
      t.column :grade_id, :integer
    end 
  end

  def self.down
    drop_table :grades_ofertas
  end
end
