user = 'root'
ip_address = '103.18.6.158'

role :app, ["#{user}@#{ip_address}"]
role :web, ["#{user}@#{ip_address}"]
role :db,  ["#{user}@#{ip_address}"]

server ip_address,
       user: user,
       roles: %w(web app),
       my_property: :my_value

set :rails_env, 'production'

set :bundle_flags, '--no-deployment'

set :ssh_options,
  {
    auth_methods: %w(publickey password),
    port: 2000
  }
