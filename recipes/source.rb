#
# Cookbook Name:: streamtools
# Recipe:: source
#

# make sure the GOPATH directory structure exists
directory "/home/ubuntu/go/src/github.com/nytlabs/streamtools" do
  action :create
  recurse true
end

# grab the specified repository and branch of streamtools
# then notify the next block to build and run it
git "/home/ubuntu/go/src/github.com/nytlabs/streamtools" do
  repository node['streamtools']['repository']
  revision node['streamtools']['branch']
  action :sync
  user "ubuntu"
  notifies :run, "bash[build_streamtools]"
end

# this is only run when the git block tells it to
bash "build_streamtools" do
  cwd "/home/ubuntu/go/src/github.com/nytlabs/streamtools"
  user "ubuntu"
  code <<-EOH
     make
     ./build/st > /tmp/streamtools.log 2>&1 &
  EOH
  action :nothing
end

