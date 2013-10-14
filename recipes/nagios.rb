#
# Cookbook Name:: ohai-ipmi
# Recipe:: nagios
#
# Copyright (C) 2013 ZippyKid Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "ohai-ipmi::freeipmi"

if node['ipmi']['available']
  cpan_module "IPC::Run"

  cookbook_file "#{node['nagios']['plugin_dir']}/check_ipmi_sensor" do
    source "check_ipmi_sensor"
    owner "root"
    group "root"
    mode 00755
  end

  nagios_nrpecheck "check_ipmi_sensor" do
    command "#{node['nagios']['plugin_dir']}/check_ipmi_sensor"
    parameters "-H localhost"
  end
end

