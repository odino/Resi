require 'rubygems'
require 'rack'
require 'httparty'

class Resi
  include HTTParty

  def call(env)
    self.class.basic_auth 'a', 'admin'
    response = self.class.get('http://127.0.0.1:2480/database/demo');
    request = Rack::Request.new(env)
    [response.code, {"Content-Type" => "text/html"}, response.body]
  end
end

Rack::Handler::Thin.run Resi.new, :Port => 9292
