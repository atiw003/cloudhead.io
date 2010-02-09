require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if Toto.env == 'development'
  use Rack::ShowExceptions
end

# Run application
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  #
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :url, "http://cloudhead.io"
  set :root, 'home'
  set :title, 'cloudhead.io'
  set :github, :user => 'cloudhead', :repos => [
    'toto', 'mutter', 'eyes.js', 'cradle', 
    'journey', 'vows.js', 'less', 'proto.js', 'koi'
  ]
end

module Toto
  module Template
    def to_html page, &blk
      path = (page == :layout ? Toto::Paths[:templates] : Toto::Paths[:pages])
      ERB.new(File.read("#{path}/#{page.to_s.downcase}.rhtml")).result(binding)
    end
  end
end

run toto

