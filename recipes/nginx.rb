#
# Cookbook Name:: streamtools
# Recipe:: nginx
#

# make sure the GOPATH directory structure exists

template "/etc/nginx/sites-available/streamtools" do
  source "nginx.streamtools.conf"
end

link "/etc/nginx/sites-enabled/streamtools" do
  to "/etc/nginx/sites-available/streamtools"
end

