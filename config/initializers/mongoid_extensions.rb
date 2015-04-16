module MongoidExtenions
  module CriteriaExtensions
    def filter_by(filters)
      criteria = self.clone
      _filters = klass.admin_filters.keys
      filters.each do |filter, value|
        next if !_filters.include?(filter) || value.blank?

        criteria = case admin_filters[filter][:type]
                   when 'regex'
                     criteria.where(filter => /#{value}/i)
                   else
                     criteria.where(filter => value)
                   end

      end
      criteria
    end
  end
end

Mongoid::Criteria.include(MongoidExtenions::CriteriaExtensions)

