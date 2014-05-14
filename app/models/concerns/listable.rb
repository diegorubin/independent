module Listable
  extend ActiveSupport::Concern

  included do
    after_save :create_or_update_item_in_list
  end

  def create_or_update_item_in_list
    return unless self.published
    item = ListItem.find_or_initialize_by(
      {resource_type: self.class.name, resource_id: self.id.to_s}
    )

    [
      :title, :resume, :tags, :published_at, :slug, :date, :author
    ].each do |attr|
      item.send("#{attr}=", self.send(attr))
    end

    item.save
  end

end

