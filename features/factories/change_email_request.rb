
Factory.define :change_email_request, :class => User::ChangeEmailRequest do |r|
  r.key "1234"
  r.new_email { Factory.next :user_email }
  r.association :user, :factory => :user
end
