require 'digest/sha1'

#******* IMPORTANTE *****

#Lembrar que qualquer novo campo que seja colocado em Usuario, 
#deve ser adicionado ali nos attr_acessible



class Usuario < ActiveRecord::Base
  
  has_attached_file :avatar, :styles => { :medium => "250x250>", :small => "80x80>", :mini => "54x54>" }
  
  validates_attachment_size :avatar, :less_than => 3.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  has_many :grades
  
  has_many :assets
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  #validates_presence_of     :login
  #validates_length_of       :login,    :within => 3..40
  #validates_uniqueness_of   :login
  #validates_format_of       :login,    :with => Authentication.login_regex, :message => " inválido"

  validates_presence_of     :nome,     :message => " deve ser preenchido"
  validates_format_of       :nome,     :with => Authentication.name_regex,  :message => " inválido", :allow_nil => true
  validates_length_of       :nome,     :maximum => 100, :message => " de tamanho inválido" 
  validates_length_of       :nome,     :minimum => 3,   :message => " de tamanho inválido" 
  
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :message => " já existente"
  validates_format_of       :email,    :with => Authentication.email_regex, :message => " inválido"

  before_create :make_activation_code 
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  #attr_accessible :login, :email, :nome, :password, :password_confirmation
  attr_accessible :email, :curso_id, :semestre, :nome, :avatar,  :password, :password_confirmation
  
  
    # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  
  def recently_activated?
    @activated
  end


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

#  def login=(value)
#    write_attribute :login, (value ? value.downcase : nil)
#  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  
  def create_reset_code
    @reset = true
    self.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    save(false)
  end 
  
  def recently_reset?
    @reset
  end
  
  def delete_reset_code
    self.reset_code = nil
    save(false)
  end
  
    
  protected
      def make_activation_code
        self.activation_code = self.class.make_token
      end

  
end
