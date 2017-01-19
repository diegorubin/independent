FactoryGirl.define do
  factory :html_container, class: Widget do
    manifest <<MANIFEST
widget:
  name: HTMLContainer
  label: html_container

  config_model: HTMLContainer

  models:
    - HTMLContainer
MANIFEST
  end
end

