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

end
