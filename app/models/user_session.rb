class UserSession < Authlogic::Session::Base
  # http://rdoc.info/projects/binarylogic/authlogic

  before_validation :validated_users
  def validated_users
    if attempted_record and not attempted_record.validated?
      errors.add_to_base "Invalid user"
    end
  end
end
