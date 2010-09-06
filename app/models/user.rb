class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.disable_perishable_token_maintenance = true
    config.perishable_token_valid_for = 2.days.to_i
    config.maintain_sessions = false
  end

  validators_on(:email).detect {|v| ActiveModel::Validations::FormatValidator === v }.options[:message] = :email_invalid

  has_friendly_id :complete_name, :use_slug => true, :approximate_ascii => true
  has_attached_file :photo, :styles => {:thumb => "100x100>" }


  attr_accessible :name, :surname, :birth_date, :gender, :city, :postcode,
                  :country, :hobbies, :gtalk, :skype, :website, :about,
                  :password, :password_confirmation, :current_password, :terms_of_use,
                  :photo

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
  scope :confirmed, where("confirmed_at IS NOT NULL AND deleted_at IS NULL")

  def admin?
    confirmed? && role == Role::Admin
  end

  def company?
    confirmed? && role == Role::Company
  end

  def complete_name
    [name, surname].join(" ")
  end

  def confirmed?
    confirmed_at && deleted_at.nil?
  end

  before_create :assign_perishable_token
  def assign_perishable_token
    if perishable_token.blank?
      reset_perishable_token
    end
  end


end
