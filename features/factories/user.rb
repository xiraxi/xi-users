# http://github.com/thoughtbot/factory_girl

Factory.sequence(:user_email) {|n| "user-#{n}@generated.xi" }

Factory.define :user do |u|
    u.email { Factory.next :user_email }
    u.name "Generated"
    u.surname "Surname"

    u.password "test.pw"
    u.password_confirmation {|newuser| newuser.password }

    u.about "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    u.birth_date Date.new(1980, 01, 01)
    u.gender User::Gender::Male
    u.city "Oslo"
    u.country "Norway"

    u.validated_at { Time.now - 1.day }

    #u.gtalk
    #u.skype
    #u.web
end

User.class_eval do
  def admin=(v)
    self.role = v ? User::Role::Admin : User::Role::Regular
  end

  def admin
    admin?
  end
end
