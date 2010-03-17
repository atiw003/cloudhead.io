require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if Toto.env == 'development'
  use Rack::ShowExceptions
end

class Toto::Site
  def log *args
    index *args
  end
end

# Run application
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  #
  set :date do |now|
    now.strftime("%B #{now.day.ordinal} %Y")
  end
  set :url, "http://cloudhead.io"
  set :author, "cloudhead"
  set :root, 'home'
  set :title, 'cloudhead.io'
  set :github, :user => 'cloudhead', :repos => [
    'toto', 'mutter', 'eyes.js', 'cradle', 
    'journey', 'vows.js', 'less', 'proto.js', 'koi'
  ]
end

run toto

