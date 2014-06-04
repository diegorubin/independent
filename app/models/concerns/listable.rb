module Listable
  extend ActiveSupport::Concern

  included do
    after_save :create_or_update_item_in_list
    after_destroy :destroy_item_in_list
  end

  def resource_type
    self.class.name
  end

  def create_or_update_item_in_list
    item = ListItem.find_or_initialize_by(
      {resource_type: self.class.name, resource_id: self.id.to_s}
    )

    [
      :title, :resume, :tags, :published_at, :slug, :date, :author,
      :category, :number_of_comments
    ].each do |attr|
      item.send("#{attr}=", self.send(attr))
    end

    if self.published
      item.save
    else
      item.destroy unless item.new_record?
    end
  end

  def destroy_item_in_list
    item = ListItem.where(
      {resource_type: self.class.name, resource_id: self.id.to_s}
    ).first
    item.destroy if item
  end

end

