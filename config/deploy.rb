# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "PawfectTrip"
set :repo_url,  'git@github.com:s-yamauchi07/PawfectTrip'
set :branch, 'main'

set :rbenv_type, :user
set :rbenv_ruby, '3.2.0'

# pumaの起動用の記載
set :puma_service_unit_name, 'puma.service'

# nginxの設定
set :nginx_config_name, 'pawfect-trip.com'

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'
append :linked_files, "config/master.key"
# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets",  '.bundle'

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/perfecttrip_ssh.pem'] 