#
# Cookbook:: mypostgresql
# Recipe:: user
#
# Copyright:: 2018, The Authors, All Rights Reserved.

postgresql_access 'local_postgres_superuser' do
  comment 'Local postgres superuser access'
  access_type 'local'
  access_db 'all'
  access_user 'postgres'
  # access_addr nil
  # access_method 'ident'
  # notifies :reload
  notifies :reload, 'service[postgresql]'
end

postgresql_user 'postgres' do
#  superuser true
  password 'P0sgresP4ssword'
end

postgresql_user 'pguser1' do
  password 'P0sgresP4ssword'
  createdb true
end

postgresql_access 'a testdatabase local superuser' do
  access_type 'host'
  access_db 'all'
  access_user 'pguser1'
  access_method 'md5'
  access_addr '127.0.0.1/32'
  notifies :reload, 'service[postgresql]'
end

postgresql_database 'testdatabase' do
	owner 'postgres'
  # port 5432
end

service 'postgresql' do
  extend PostgresqlCookbook::Helpers
  service_name lazy { platform_service_name }
  supports restart: true, status: true, reload: true
  action :nothing
end
