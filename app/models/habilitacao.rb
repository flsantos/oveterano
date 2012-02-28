class Habilitacao < ActiveRecord::Base
  
  belongs_to :curso
  has_one :fluxo
  belongs_to :fluxo
  has_one :curriculo
  belongs_to :curriculo
  
  validates_uniqueness_of(:codigo, :message => " já existente!")
  
  
end
