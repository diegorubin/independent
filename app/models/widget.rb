class Widget
  include Mongoid::Document

  include Uploadable

  def config
    klass = manifest['widget']['config_model'].constantize
    klass.first || create_and_return(klass)
  end

  def self.path
    Rails.root.join('widgets')
  end

  private
  def create_and_return(klass)
    obj = klass.new
    obj.save && obj
  end

end

