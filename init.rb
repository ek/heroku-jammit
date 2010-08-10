begin
  require 'jammit'
rescue LoadError
  raise "jammit gem is missing.  Please install jammit: sudo gem install jammit"
end
require File.dirname(__FILE__) + '/lib/heroku_jammit_command'
require File.dirname(__FILE__) + '/lib/help'

