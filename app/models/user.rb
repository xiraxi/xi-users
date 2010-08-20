class User < ActiveRecord::Base

  acts_as_authentic

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

  def admin?
    role == Role::Admin
  end

  def company?
    role == Role::Company
  end

  scope :admins, where(:role => Role::Admin)
  scope :valid, where("validated_at IS NOT NULL")

  attr_accessible :name, :surname, :birth_date, :gender, :city, :postcode,
                  :country, :hobbies, :gtalk, :skype, :website, :about,
                  :password, :password_confirmation, :current_password, :terms_of_use


  # Password modification logic
  attr_accessor :current_password
  validates :current_password, :valid_password => true

  def complete_name
    [self.name, self.surname].join(" ")
  end

  # TO DO
  def photo
    nil
  end

end
