class Widget
  include Mongoid::Document

  include Uploadable

  def self.path
    Rails.root.join('widgets')
  end

end

