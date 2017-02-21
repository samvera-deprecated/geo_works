require 'solr_wrapper'
require 'fcrepo_wrapper'

namespace :geo_works do
  desc 'Run style checker'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rspec'
    task.fail_on_error = true
  end

  RSpec::Core::RakeTask.new(:rspec)

  desc 'Run test suite'
  task :spec do
    with_server 'test' do
      Rake::Task['geo_works:rspec'].invoke
    end
  end
  desc "Run development servers for Geo Works"
  task :dev_servers do
    with_server 'development' do
      begin
        Rake::Task['engine_cart:server'].invoke
      rescue Interrupt
        puts "Shutting down..."
      end
    end
  end
  desc "Run test servers for Geo Works"
  task :test_servers do
    with_server 'test' do
      begin
        sleep
      rescue Interrupt
        puts "Shutting down..."
      end
    end
  end
end
