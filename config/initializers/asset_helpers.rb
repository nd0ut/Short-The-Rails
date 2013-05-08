Rails.application.assets.context_class.class_eval do
  include ActionView::Helpers
  include Devise::OmniAuth::UrlHelpers
  include Rails.application.routes.url_helpers
end