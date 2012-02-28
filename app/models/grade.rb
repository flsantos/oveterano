class Grade < ActiveRecord::Base
  
  
  belongs_to :usuario
  has_and_belongs_to_many :ofertas
  
  
  validates_presence_of(:nome, :message => " é obrigatório!")
  validates_presence_of(:semestre, :message => " é obrigatório!")
  
  validates_length_of       :nome,     :maximum => 100, :message => " de tamanho inválido" 
  validates_length_of       :nome,     :minimum => 3,   :message => " de tamanho inválido" 
  
end
