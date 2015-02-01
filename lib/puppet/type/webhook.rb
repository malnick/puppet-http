Puppet::Type.newtype(:webhook) do
  desc "Run puppet on a node"

  ensurable do

      newvalue(:get) do
          provider.get
      end

      newvalue(:post) do
          provider.post
      end

      newvalue(:listen) do
          provider.listen
      end

  end

  newproperty(:route, :namevar => true) do
    desc "Route to post or get or to listen"
  end

  newproperty(:port) do
      desc "The listening port"
  end

end

