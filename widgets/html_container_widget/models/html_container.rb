class HTMLContainer
  include Mongoid::Document
  include AdminForm::Settings

  field :title, type: String
  field :content, type: String

  form_field :content, 'text'

end

