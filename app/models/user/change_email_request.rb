class User::ChangeEmailRequest < ActiveRecord::Base
  belongs_to :user

  before_save :assign_key
  def assign_key
    while self.key.blank?
      key = SecureRandom.hex(12)
      if self.class.where(:key => key).count == 0
        self.key = key
      end
    end
  end

  after_save :send_notification
  def send_notification
    User::Notifier.change_email(self).deliver
  end

  # Deletes old request
  def self.cleanup!
    delete_all ['created_at < ?', 2.days.ago]
  end


  def validate_email
    user.email = new_email
    user.save
  end

end
