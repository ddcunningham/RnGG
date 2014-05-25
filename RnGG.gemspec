Gem::Specification.new do |s|
  s.name         = "RnGG"
  s.version      = "1.0"
  s.author       = "Me in part, but mostly this little ruby tutorial"
  s.email        = ""
  s.homepage     = "http://github.com/ddcunningham"
  s.summary      = "a crappy little diceroll game that i'll probably turn into a DnD game later"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'RnGG' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
