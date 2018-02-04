set :stage, :production
set :rails_env, :production
set :deploy_to, "/deploy/apps/vinalign"
set :branch, :develop
server ENV["VINALIGN_ADDRESS"], user: ENV["VINALIGN_USER_DEPLOY"], roles: %w(web app db)
