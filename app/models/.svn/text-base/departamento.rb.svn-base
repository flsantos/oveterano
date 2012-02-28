class Departamento < ActiveRecord::Base
  has_many :disciplinas
  
  validates_uniqueness_of(:nome, :message => " já existente!")
  validates_uniqueness_of(:codigo, :message => " já existente!")
  
  
  def professores
  	self.disciplinas.collect{|c| c.ofertas}.flatten.uniq.collect{|p| p.professores}.flatten.uniq
  end
  
end
