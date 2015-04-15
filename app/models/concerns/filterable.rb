module Filterable
  extend ActiveSupport::Concern
  included do
    def self.filter_by(filters)
      Mongoid::Criteria.new(self).filter_by(filters)
    end
  end
end

