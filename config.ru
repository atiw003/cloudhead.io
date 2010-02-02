require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

# Run application
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  #
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :url, "http://cloudhead.io"
  set :root, 'index'
end

run toto

