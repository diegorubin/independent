class Setting
  include Mongoid::Document

  field :title,    type: String
  field :category, type: String
  field :value,    type: String
  field :theme,    type: String

  validates :title, presence: true, uniqueness: {scope: ['theme']}
  validates :category, presence: true
  validates :theme, presence: true

  # Scopes
  scope :admin_list, proc {|theme|
    where(theme: theme).order([['category', 'asc']])
  }

  # XXX: Estudar o melhor a criação de mapreduce
  # Deixando desta forma para não empacar
  def self.map_settings_by_category
    map = %Q{
      function() {
        
        var item = {};
        item[this.title] = this.value;

        emit(this.theme, item);
      }
    }
    reduce = %Q{
      function(theme, value) {
        result = {};
        result[theme] = value;
        return result;
      }
    }
    Setting.map_reduce(map, reduce).out(inline: true)
  end

end

