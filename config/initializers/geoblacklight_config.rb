require 'active_support/core_ext/hash/indifferent_access'
module GeoWorks
  module Geoblacklight
    def config
      @config ||= config_yaml.with_indifferent_access
    end

    private

      def config_yaml
        file = File.join(GeoWorks.root, 'config', 'geoblacklight.yml')
        file = File.join(Rails.root, 'config', 'geoblacklight.yml') unless File.exist? file
        YAML.load(ERB.new(File.read(file)).result)[Rails.env]
      end

      module_function :config, :config_yaml
  end
end
