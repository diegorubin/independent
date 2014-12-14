class Link
  include Mongoid::Document

  field :description, type: String
  field :url, type: String
  field :icon, type: String

end

