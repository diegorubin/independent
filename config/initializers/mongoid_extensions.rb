module MongoidExtenions
  module CriteriaExtensions
    def filter_by(filters)
      criteria = self.clone
      _filters = klass.admin_filters.keys
      filters.each do |filter, value|
        canon = canon_filter(filter)
        next if !_filters.include?(canon) || value.blank?

        criteria = case admin_filters[canon][:type]
                   when 'regex'
                     criteria_for_regex(criteria, filter, value)
                   when 'datetime'
                     criteria_for_datetime(criteria, filter, value)
                   else
                     criteria.where(filter => value)
                   end

      end
      criteria
    end

    protected
    def criteria_for_regex(criteria, filter, value)
      begin
        criteria.where(filter => /#{value}/i)
      rescue RegexpError => e
        criteria.where()
      end
    end

    def criteria_for_datetime(criteria, filter, value)
      canon = canon_filter(filter)
      _filter = (filter =~ /ends_in/ ? canon.to_sym.lte : canon.to_sym.gte)
      _value = DateTime.strptime(value, '%d/%m/%Y %H:%M')
      criteria.where(_filter => _value)
    end

    def canon_filter(filter)
      filter.gsub(/_(starts_in|ends_in)/, '')
    end

  end
end

Mongoid::Criteria.include(MongoidExtenions::CriteriaExtensions)

