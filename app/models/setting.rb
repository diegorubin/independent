class Setting
  include Mongoid::Document

  field :title,      type: String
  field :category,   type: String
  field :value,      type: String
  field :input_type, type: String
  field :theme,      type: String
  field :domain,     type: String

  validates :title, presence: true, uniqueness: {scope: ['theme', 'domain']}
  validates :category, presence: true
  validates :theme, presence: true

  # Scopes
  scope :admin_list, proc {|theme|
    where(:theme.in => [theme, 'global'])
    .order([['category', 'asc'], ['title', 'asc']])
  }

  def self.admin_attributes
    [:value]
  end

  def self.map_settings_by_category(current_domain = nil)
    settings = 
      Setting.where(:theme.in => ['global',current_theme])
        .where(:domain.in => [nil, current_domain].uniq)
        .group_by{|t| t.theme}
    settings.each {|k, v| settings[k] = v.collect{|s| [s.title, s.value]}.to_h }
  end

  def self.current_theme
    Setting.where({theme: 'global', title: 'current_theme'}).first.try(:value)
  end

  def self.features
    settings = {}
    Setting.where({category: 'features'}).each {|s| settings[s.title] = s.value }
    settings
  end

end

