include_recipe 'apt'

%w[curl gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev build-essential nodejs].each do |pkg|
  package pkg
end

node.default["openfire"]["database"]["type"] = "postgresql"
node.default["openfire"]["database"]["password"] = "password"
node.default["postgresql"]["password"]["postgres"] = "password"

include_recipe "postgresql::server"
include_recipe "openfire"
