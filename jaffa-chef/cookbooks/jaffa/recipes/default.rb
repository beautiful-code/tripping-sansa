#
# Cookbook Name:: logg-chef
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

%w[curl gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev build-essential nodejs imagemagick].each do |pkg|
  package pkg
end

user "deploy" do
  comment "Deploy User"  
  gid "sudo"
  supports :manage_home => true # needed to actually create home dir
  home "/home/deploy"
  shell "/bin/bash"
  password '$1$VT/F5P.y$GuSLRwrDSiT2rArmstNQO1' 
end


package "openjdk-6-jdk"

include_recipe "nginx"
include_recipe "git"
include_recipe "mongodb::10gen_repo"
include_recipe "mongodb"

