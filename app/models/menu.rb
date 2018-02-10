class Menu
  include Mongoid::Document

  field :title, type: String
  field :group, type: String
  field :link,  type: String
  field :position,  type: Integer

  scope :admin_list, lambda {
  }

  scope :by_group, proc { |group|
    where(group: group).order([['postion', 'asc']])
  }

  def self.admin_attributes
    [ :title, :link, :group ]
  end

  def self.admin_filters
    {
      'title' => {type: 'regex'}, 'link' => {type: 'regex'},
      'group' => {type: 'regex'}
    }
  end
end
