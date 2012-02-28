class Reserva < ActiveRecord::Base
  
    has_and_belongs_to_many :ofertas
  
    validates_presence_of(:curso, :message => " é obrigatório!")
    validates_uniqueness_of(:curso, :message => " já existente!")
end
