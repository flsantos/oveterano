class Fluxo < ActiveRecord::Base
  
  has_and_belongs_to_many :disciplinas
  
  belongs_to :habilitacao
  has_one :habilitacao
  
  
  
  
  
end
