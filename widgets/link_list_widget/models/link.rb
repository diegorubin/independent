class Link
  include Mongoid::Document
  include AdminForm::Settings

  field :description, type: String
  field :url, type: String
  field :icon, type: String

  form_field :icon, 'image'

end

