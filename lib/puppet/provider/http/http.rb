require 'net/http'
require 'uri'
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
  end

  def exists?
  end

end
