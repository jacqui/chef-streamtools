# Add Monit configuration file via the `monitrc` definition
#
begin
  monitrc "streamtools" do
    template_cookbook "streamtools"
    template_source   "streamtools.monitrc.conf"
    source            "streamtools.monitrc.conf"
  end
rescue Exception => e
  Chef::Log.error "The 'monit' recipe is not included in the node run_list or the 'monitrc' resource is not defined"
  raise e
end
