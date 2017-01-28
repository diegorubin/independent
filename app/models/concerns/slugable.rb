module Slugable
  extend ActiveSupport::Concern

  included do
    field :slug, :type => String
    validates :slug, uniqueness: true, presence: true

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

    usage = self.class.where(slug: /#{slug}($|-\d+)/).count
    if usage > 0
      slug += "-#{usage + 1}"
    end

    write_attribute(:slug, slug)
  end

end

