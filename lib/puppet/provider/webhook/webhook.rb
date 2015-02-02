require 'net/http'
require 'uri'
Puppet::Type.type(:webhook).provide(:webhook) do
desc "Run pupppet on a node"

  def post 
    port    = resources[:port]
    route   = resources[:route]
    fqdn    = resources[:fqdn]
    url     = "#{fqdn}:#{port}/#{route}"
    unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
        raise Puppet::ParseError, "#{url}: is not a valid HTTP/HTTPS URL"
    end
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def get
  end

  def exists?
  end

end
