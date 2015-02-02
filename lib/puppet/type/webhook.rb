Puppet::Type.newtype(:webhook) do
  desc "Run puppet on a node"

  ensurable do

      newvalue(:get) do
          provider.get
      end

      newvalue(:post) do
          provider.post
      end

  end

  newproperty(:route, :namevar => true) do
    desc "Route to post or get or to listen"
  end

  newproperty(:port) do
      desc "The listening port"
  end

  newproperty(:fqdn) do
      desc "The fqdn or ip address of the node"
  end

end

