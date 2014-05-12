module Slugable
  extend ActiveSupport::Concern

  included do
    field :slug,         :type => String
    validates_presence_of :slug

    before_validation :generate_slug

    # Scope
    scope :find_by_slug, lambda { |date, slug|
      where(:date => date, :slug => slug) 
    }
    scope :find_by_simple_slug, lambda { |slug|
      where(:slug => slug) 
    }

  end

  def generate_slug
    return if title.blank? || !slug.blank?

    slug = title.no_accent
    slug.downcase!
    slug.gsub!(/[\s_]/,'-')
    slug.gsub!(/[^A-Za-z-]/,'')

    write_attribute(:slug, slug)
  end

end

