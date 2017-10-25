gem 'hyrax', '1.0.5'
gem 'geo_works'

run 'bundle install'

generate 'hyrax:install', '-f'
generate 'geo_works:install', '-f'

rails_command 'db:migrate'
rails_command 'hyrax:workflow:load'
