gem 'test_hyrax', '0.0.1.alpha'
gem 'flipflop', github: 'jcoyne/flipflop', branch: 'hydra'
gem 'geo_concerns', '0.3.4'

run 'bundle install'

generate 'hyrax:install', '-f'
generate 'geo_concerns:install', '-f'

rails_command 'db:migrate'
rails_command 'hyrax:workflow:load'
