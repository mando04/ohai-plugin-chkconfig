#
# provides information from chkconfig
# Version: 1.0.0
# Author: Armando Soto
#

provides "chkconfig"

require_plugin "hostname"

chkconfig Mash.new

%x(chkconfig --list).split("\n").each do |line|
  chkconfig["#{line.split(/\s+/)[0]}"] = Mash.new
  line.split(/\s+/)[1..-1].each do |service|
    chkconfig["#{line.split(/\s+/)[0]}"] = chkconfig["#{line.split(/\s+/)[0]}"].merge({ "#{service.split(":")[0]}" => "#{service.split(":")[-1]}" })
  end
end