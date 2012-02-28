class Horario < ActiveRecord::Base
  
    has_and_belongs_to_many :ofertas
  
    validates_presence_of(:dia, :message => " é obrigatório!")
    validates_presence_of(:horario_ini, :message => " é obrigatório!")
    validates_presence_of(:horario_fim, :message => " é obrigatório!")
    
    
    validates_uniqueness_of(:dia, :scope => [:horario_ini, :horario_fim], :message => " já existente!")
end
