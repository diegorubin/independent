class Link
  include Mongoid::Document

  field :title, type: String
  field :url, type: String
  field :icon, type: String

end

