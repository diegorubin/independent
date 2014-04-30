module Publishable
  extend ActiveSupport::Concern

  included do
    field :published_at, :type => DateTime
    field :published,    :type => Boolean

    # Field used in slug
    field :date,         :type => String

    before_save :generate_date, :generate_updated_date

    scope :ordered_by_published_at, lambda {
      order_by([["published_at", "desc"]])
    }
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

