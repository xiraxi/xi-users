Gem::Specification.new do |s|
  s.name = "xi-users"
  s.version = "0.1"
  s.date = "2010-08-17"
  s.authors = ["Xiraxi Foton Team"]
  s.email = "xiraxi@foton.es"
  s.summary = "Xiraxi Core"
  s.homepage = "http://xiraxi.foton.es"
  s.description = s.summary
  s.files = %w(app config db lib public rails tasks test).map {|dir| Dir["#{dir}/*", "#{dir}/**/*" ] }.flatten

  #s.add_dependency "authlogic"
  s.add_dependency "recaptcha"
end
