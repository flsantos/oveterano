class Asset < ActiveRecord::Base
  has_attached_file :data

  belongs_to :attachable, :polymorphic => true
  belongs_to :usuario
  
  
  
  validates_attachment_size :data, :less_than => 1.megabytes
  validates_attachment_content_type :data, :content_type => ['text/plain', 'application/pdf', 'application/zip', 'image/gif', 'image/jpeg', 'image/png', 'application/vnd.oasis.opendocument.text', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/x-latex', 'application/x-rar-compressed', 'application/octet-stream']
  
  validates_length_of       :descricao,     :maximum => 200, :message => " de tamanho inválido"
    
  
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def file_size
    data_file_size
  end
end