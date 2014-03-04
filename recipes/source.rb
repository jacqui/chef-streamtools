#
# Cookbook Name:: streamtools
# Recipe:: source
#

# make sure the GOPATH directory structure exists
directory node['streamtools']['directory'] do
  action :create
  recursive true
end

# grab the specified repository and branch of streamtools
# then notify the next block to build and run it
git node['streamtools']['directory'] do
  repository node['streamtools']['repository']
  revision node['streamtools']['branch']
  action :sync
  user "ubuntu"
  notifies :run, "bash[build_streamtools]"
end

service "streamtools" do
  provider Chef::Provider::Service::Upstart
  supports :enable => true, :restart => true, :status => true
  notifies :run, "bash[post_pattern]", :delayed
end

# this is only run when the git block tells it to
bash "build_streamtools" do
  cwd node['streamtools']['directory']
  user "ubuntu"
  code <<-EOH
     make
  EOH
  only_if do
    !File.exists?("#{node['streamtools']['directory']}/build/st")
  end
  action :run
  notifies :restart, "service[streamtools]", :delayed
end

template "/etc/init/streamtools.conf" do
  source "upstart.streamtools.conf"
  notifies :restart, "service[streamtools]", :delayed
end

