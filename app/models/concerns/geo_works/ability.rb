module GeoWorks
  module Ability
    extend ActiveSupport::Concern
    included do
      self.ability_logic += [:geo_works_permissions]
    end

    def geo_works_permissions
      alias_action :geoblacklight, to: :read
    end
  end
end
