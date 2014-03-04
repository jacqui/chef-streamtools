#
# Cookbook Name:: streamtools
# Recipe:: patterns
#

# load pattern from specified repo
# then notify the http block to post it
git node['streamtools']['patterns_directory'] do
  repository node['streamtools']['patterns_repository']
  revision node['streamtools']['patterns_branch']
  action :sync
  user "ubuntu"
  notifies :restart, "service[streamtools]", :immediately
  notifies :run, "bash[post_pattern]", :delayed
  not_if do
    node['streamtools']['patterns_repository'] == ''
  end
end

# post it to local instance of streamtools
bash "post_pattern" do
  code <<-EOH
    curl -XPOST http://localhost:7070/import -d@#{File.join(node['streamtools']['patterns_directory'], node['streamtools']['pattern_file'])}
  EOH
  action :nothing
  only_if do
    File.exists?(File.join(node['streamtools']['patterns_directory'], node['streamtools']['pattern_file'])) || node['streamtools']['force_post_pattern']
  end
end

