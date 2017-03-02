gem 'hyrax', '0.0.1.alpha'
gem 'geo_works'

run 'bundle install'

generate 'hyrax:install', '-f'
generate 'geo_works:install', '-f'

rails_command 'db:migrate'
rails_command 'hyrax:workflow:load'
