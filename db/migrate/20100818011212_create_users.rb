class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :password
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
      t.datetime :validate_key

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
