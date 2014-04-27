module Slugable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug
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

