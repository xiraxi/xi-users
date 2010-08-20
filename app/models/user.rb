class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.disable_perishable_token_maintenance = true
  end

  attr_accessible :name, :surname, :birth_date, :gender, :city, :postcode,
                  :country, :hobbies, :gtalk, :skype, :website, :about,
                  :password, :password_confirmation, :current_password, :terms_of_use

  # Password modification logic
  attr_accessor :current_password

  validates :current_password, :valid_password => true
  validates :terms_of_use, :acceptance => true

  module Gender
    Male = "male"
    Female = "female"
  end

  module Role
    Admin = "Admin"
    Regular = ""
    Company = "Company"
  end

  after_create :send_signup_email
  def send_signup_email
    User::Notifier.signup(self).deliver
  end

  scope :admins, where(:role => Role::Admin)
  scope :valid, where("validated_at IS NOT NULL")

  def admin?
    role == Role::Admin
  end

  def company?
    role == Role::Company
  end

  def complete_name
    [self.name, self.surname].join(" ")
  end

  def validated?
    !validated_at.nil?
  end

  # TO DO
  def photo
    nil
  end

  before_create :assign_perishable_token
  def assign_perishable_token
    if perishable_token.blank?
      reset_perishable_token
    end
  end


end
