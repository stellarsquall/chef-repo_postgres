# # encoding: utf-8

# Inspec test for recipe mypostgresql::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os[:family] == 'redhat'
  describe service('postgresql-9.6') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
else
  describe service('postgresql') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

if os[:family] == 'redhat'
	describe port('5432') do
	  its('processes') { should include 'postmaster' }
	end
else
	describe port('5432') do
	  its('processes') { should include 'postgres' }
	end
end

# describe postgres_conf do
#   its('port') { should eq '5432' }
#   # its('max_connections') { should eq '5' }
# end

# describe postgres_hba_conf.where { type == 'local' } do
#  its('auth_method') { should include ['peer'] }
# end

# describe postgres_hba_conf.where { pg_username == 'postgres' } do
#   its('pg_username') { should eq ['postgres'] }
# end

sql = postgres_session('database_user', '67890', '127.0.0.1')
describe sql.query('\conninfo', ['roux_art']) do
  its('output') { should match 'connected' }
end

postgres_access = postgres_session('database_user', '67890', '127.0.0.1')
describe postgres_access.query('SELECT 1;', ['postgres']) do
  its('output') { should eq '1' }
end

describe sql.query("SELECT artist_name FROM artists;", ['roux_art']) do
  its('output') { should match 'dali' }
end