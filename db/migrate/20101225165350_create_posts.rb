class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :mensagem
      t.integer :alias
      t.integer :alias_id
      t.integer :autor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
