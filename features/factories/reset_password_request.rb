
Factory.define :reset_password_request, :class => User::ResetPasswordRequest do |r|
  r.key "1234"
  r.association :user, :factory => :user
end
