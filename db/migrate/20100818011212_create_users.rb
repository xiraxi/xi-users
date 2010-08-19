class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :role

      t.string :name
      t.string :surname
      t.text :profile
      t.date :born
      t.string :gender
      t.string :city

      t.string :gtalk
      t.string :skype
      t.string :web

      t.datetime :validated_at

      # Authentica fields, see Authlogic::Session::Perishability
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token

      # See Authlogic::Session::MagicColumns
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count,  :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
