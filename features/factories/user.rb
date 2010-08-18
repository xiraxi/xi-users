# http://github.com/thoughtbot/factory_girl

Factory.sequence(:user_email) {|n| "user-#{n}@generated.xi" }

Factory.define :user do |u|
    u.email { Factory.next :user_email }
    u.name "Generated"
    u.password "test.pw"
    u.surname "Surname"
    u.profile "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    u.born Date.new(1980, 01, 01)
    u.gender User::Gender::Male
    u.city "Oslo"

    u.validated_at { Time.now - 1.day }

    #u.gtalk
    #u.skype
    #u.web
end
