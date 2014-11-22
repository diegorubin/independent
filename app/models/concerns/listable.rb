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
      :category, :number_of_comments, :pageviews
    ].each do |attr|
      item.send("#{attr}=", self.send(attr))
    end

    item.words_index = []
    item.words_index += index(resume) if respond_to?(:resume)
    item.words_index += index(body) if respond_to?(:body)
    item.words_index.uniq!

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

  private

  def index(text)
    text = (text || '').gsub(/[\+=\*\.,\?!\\:;]/, '')
    ar_text = text.split
    ar_text.collect!{|w| w.no_accent.downcase }
    ar_text.uniq - STOPWORDS
  end

end

