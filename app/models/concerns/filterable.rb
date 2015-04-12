module Filterable
  extend ActiveSupport::Concern

  included do
    def self.filter_by(filters)
      ar_proxy = self.name.constantize

      _filters = ar_proxy.admin_filters.keys
      relation = ar_proxy
      filters.each do |filter, value|
        next if !_filters.include?(filter) || value.blank?

        relation = case admin_filters[filter][:type]
                   when 'regex'
                     relation.where(filter => /#{value}/)
                   else
                     relation.where(filter => value)
                   end

      end

      relation
    end
  end
end

