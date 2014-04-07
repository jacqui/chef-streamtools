#
# Cookbook Name:: streamtools
# Recipe:: source
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "git"
include_recipe "golang"

# make sure the GOPATH directory structure exists
directory node['streamtools']['directory'] do
  action :create
  user "ubuntu"
  recursive true
end

# grab the specified repository and branch of streamtools
# then notify the next block to build and run it
git node['streamtools']['directory'] do
  repository node['streamtools']['repository']
  revision node['streamtools']['branch']
  action :sync
  user "ubuntu"
  notifies :run, "bash[build_streamtools]", :immediately
end

# this is only run when the git block tells it to
bash "build_streamtools" do
  cwd node['streamtools']['directory']
  environment "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/go/bin:/home/ubuntu/go/bin", "GOPATH" => "/home/ubuntu/go"
  user "ubuntu"
  code <<-EOH
     make
  EOH
  notifies :restart, "service[streamtools]", :delayed
end

template "/etc/init/streamtools.conf" do
  source "upstart.streamtools.conf"
  notifies :restart, "service[streamtools]", :immediately
end

service "streamtools" do
  provider Chef::Provider::Service::Upstart
  supports :enable => true, :restart => true, :status => true
  action :restart
end

