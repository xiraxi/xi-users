class CreateUserChangeEmailRequests < ActiveRecord::Migration
  def self.up
    create_table :user_change_email_requests do |t|
      t.belongs_to :user
      t.string :new_email
      t.string :key

      t.timestamps
    end

    add_index :user_change_email_requests, :key, :unique => true
  end

  def self.down
    drop_table :user_change_email_requests
  end
end
