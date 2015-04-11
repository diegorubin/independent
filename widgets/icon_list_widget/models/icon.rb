class Icon
  include Mongoid::Document
  include AdminForm::Settings

  field :url, type: String
  field :icon, type: String

  form_field :icon, 'image'

end

