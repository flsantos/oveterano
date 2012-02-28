class Curso < ActiveRecord::Base
  belongs_to :campus
  has_many :habilitacoes
  
  validates_uniqueness_of(:codigo, :message => " já existente!")
  
end
