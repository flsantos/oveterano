class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table "usuarios", :force => true do |t|
      t.string   :nome,                      :limit => 100, :default => '', :null => true
      t.string   :email,                     :limit => 100
      t.integer  :curso_id
      t.string   :semestre,                  :limit => 6
      t.string   :crypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :remember_token,            :limit => 40
      t.datetime :remember_token_expires_at
      
      t.string    :avatar_file_name
      t.string    :avatar_content_type
      t.integer   :avatar_file_size
      t.datetime  :avatar_updated_at

      t.string   :activation_code,           :limit => 40
      t.datetime :activated_at
      
      t.string   :reset_code

    end
    add_index :usuarios, :email, :unique => true
   end

  def self.down
    drop_table "usuarios"
  end
  
end
