module Publishable
  extend ActiveSupport::Concern

  included do
    field :published_at, type: DateTime
    field :published,    type: Boolean, default: false

    # Field used in slug
    field :date,         type: String

    before_save :generate_date, :generate_updated_date

    scope :publisheds, -> {
      where(published: true)
    }

    scope :ordered_by_published_at, -> {
      order([["published_at", "desc"]])
    }

  end

  def published_str
    published.to_s.to_sym.t(scope: ['options'])
  end

  def generate_date
    if published? && !date
      write_attribute(:date,Time.current.strftime("%Y/%m/%d"))
      write_attribute(:published_at, Time.current)
    end
  end

  def generate_updated_date
    write_attribute(:updated_at, Time.current)
  end

end

