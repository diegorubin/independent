class Admin::Api::V1::MarkdownController < Admin::ApiController
  skip_before_filter :check_api_key_pipeline
  before_filter :authenticate_user!

  def create
    render layout: false, text: params[:markdown].from_markdown_to_html
  end

end

