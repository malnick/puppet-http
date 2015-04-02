require 'net/http'
require 'uri'
require 'json'

Puppet::Type.type(:http).provide(:http) do
desc "Run pupppet on a node"

  def get 
    port    = resource[:port]
    route   = resource[:route]
    fqdn    = resource[:fqdn]
    url     = "http://#{fqdn}:#{port}/#{route}"
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def post
    port      = resource[:port]
    route     = resource[:route]
    fqdn      = resource[:fqdn]
    json      = resource[:data].to_json
    url       = "http://#{fqdn}:#{port}/#{route}"
    uri       = URI(url)
    http      = Net::HTTP.new(uri.host, uri.port)
    req       = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.body  = json
    response  = http.request(req)
    #Net::HTTP.post_form(uri, json)
  end

  def exists?
  end

end
