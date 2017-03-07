module GeoWorks
  module Events
    def config
      @config ||= config_yaml.with_indifferent_access
    end

    def generator
      GeoWorks::EventsGenerator.new
    end

    private

      def config_yaml
        config_file = "#{Rails.root}/config/geo_works_messaging.yml"
        YAML.load(ERB.new(File.read(config_file)).result)[Rails.env]
      end

      module_function :config, :config_yaml, :generator
  end
end
