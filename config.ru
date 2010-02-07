require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if Toto.env == 'production'
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
end

module Toto
  module Template
    def to_html page, &blk
      path = (page == :layout ? Toto::Paths[:templates] : Toto::Paths[:pages])
      ERB.new(File.read("#{path}/#{page.downcase}.rhtml")).result(binding)
    end
  end
end

run toto

