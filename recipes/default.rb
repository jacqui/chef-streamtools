#
# Cookbook Name:: streamtools
# Recipe:: default
#

remote_file "/tmp/streamtools-#{node['streamtools']['version']}.tar.gz" do
  source "https://github.com/nytlabs/streamtools/releases/download/#{node['streamtools']['version']}/st-linux-#{node['streamtools']['version']}.gz"
  action :create_if_missing
end

bash 'extract_streamtools' do
  cwd '/tmp'
  code <<-EOH
    tar xzf /tmp/streamtools-#{node['streamtools']['version']}.tar.gz
    cp /tmp/st-#{node['streamtools']['version']} /usr/local/bin/st
    /usr/local/bin/st > /tmp/streamtools.log 2>&1 &
    EOH
end


