require 'serverspec'
require 'yaml'

set :backend, :exec

# ensure packages are installed
case os[:family]
  when 'fedora', 'redhat'
    describe package('procps-ng') do
      it { should be_installed }
    end
    describe file('/etc/sysctl.conf') do
      it { should be_file }
    end
  else
   describe package('procps') do
     it { should be_installed }
   end
   describe file('/etc/sysctl.d') do
     it { should be_directory }
   end
end

# ensure values are set correctly
if File.exists? ('/tmp/kitchen/srv/pillar/sysctl.sls')
  sysctl_vars = YAML.load_file('/tmp/kitchen/srv/pillar/sysctl.sls')
  if ! sysctl_vars.nil?
    describe command('sysctl -a') do
      sysctl_vars['sysctl']['lookup']['params'].each do | param |
        its(:stdout) { should contain(param['name']) }
        its(:stdout) { should contain(param['value']) }
      end
    end
  end
end
