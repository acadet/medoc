require File.dirname(__FILE__) + '/lib/medoc'

Gem::Specification.new do |s|
  s.name = 'medoc'
  s.version = Medoc.version
  s.date = Date.today.to_s
  s.summary = ''
  s.description = ''
  s.homepage = 'https://github.com/acadet/medoc'
  s.authors = [ 'Adrien Cadet' ]
  s.email = 'acadet@live.fr'
  s.files = [ 'README.md', 'bin/medoc', 'lib/medoc.rb' ]
  s.executables = [ 'medoc' ]
end