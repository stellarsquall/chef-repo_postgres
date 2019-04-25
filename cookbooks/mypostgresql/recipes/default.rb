#
# Cookbook:: mypostgresql
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'daily'

postgresql_repository 'install' 

postgresql_client_install 'postgresql client'

postgresql_server_install 'postgresql' do
  setup_repo true
  action [:install, :create]
end

postgresql_server_conf 'PostgreSQL Config'

postgresql_access 'postgresql host superuser' do
  access_type 'host'
  access_db 'all'
  access_user 'postgres'
  access_addr '127.0.0.1/32'
  access_method 'md5'
  notifies :reload, 'service[postgresql]'
end

postgresql_user 'database test user' do
  user 'database_user'
  superuser true
  password '67890'
end

# breakpoint 'break'
# cat /var/lib/pgsql/9.6/data/pg_hba.conf

postgresql_access 'a database local superuser' do
  access_type 'host'
  access_db 'all'
  access_user 'database_user'
  access_method 'md5'
  access_addr '127.0.0.1/32'
  notifies :reload, 'service[postgresql]'
  # notifies :create, 'postgresql_database[roux_art]'
  # notifies :create, "cookbook_file[#{Chef::Config['file_cache_path']}/seed.sql]"
  # notifies :run, 'execute[seed test database]'
end

service 'postgresql' do
  extend PostgresqlCookbook::Helpers
  service_name lazy { platform_service_name }
  supports restart: true, status: true, reload: true
  # action :nothing
end

postgresql_database 'roux_art' do
	not_if "PGPASSWORD=67890 psql -c \"SELECT datname from pg_database WHERE datname='roux_art'\" -d roux_art -U database_user -p 5432 -h 127.0.0.1 | grep roux_art"
	# action :nothing
end

# Write schema seed file to filesystem
cookbook_file "#{Chef::Config['file_cache_path']}/seed.sql" do
  source 'seed.sql'
  owner 'root'
  group 'root'
  mode '0600'
  # action :nothing
end

execute 'seed test database' do
  command "PGPASSWORD=67890 psql -d roux_art -U database_user -p 5432 -h 127.0.0.1 < #{Chef::Config['file_cache_path']}/seed.sql"
  # action :nothing
end
