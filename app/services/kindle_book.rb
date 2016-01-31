require 'kindlerb'

class KindleBook
  include ApplicationHelper
  include ActionView::Context
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper 

  BOOKS_PATH = "#{Rails.root}/kindle"

  def initialize(resource_klass, slug, metadata = {})
    @resource = resource_klass.constantize.find_by(slug: slug)
    @resource_klass = resource_klass
    @slug = slug
    @metadata = metadata
  end

  def generate!
    create_structure
    Kindlerb.run(@structure_path, true, 'c1') 
    @mobi = File.join(@structure_path, file_name + '.mobi')
    true
  end

  def send_book_to(email)
    KindleMail.delay.send_book(@mobi, email)
  end

  private
  def file_name
    "#{@resource_klass}-#{@slug}"
  end

  def bookfile
    file_name + '.mobi'
  end

  def create_structure
    @structure_path = File.join(BOOKS_PATH, file_name)

    create_structure_if_not_exists
    create_metadata_file
    create_sections_directory
    create_first_section
    create_first_section_file

    create_first_article

  end

  def create_structure_if_not_exists
    Dir.mkdir(@structure_path) unless Dir.exists?(@structure_path)
  end

  def create_metadata_file
    File.open(File.join(@structure_path, "_document.yml"), 'w') do |file|
      file.write(default_metadata.merge(@metadata).to_yaml)
    end
  end

  def create_sections_directory
    @sections_path = File.join(@structure_path, "sections")
    Dir.mkdir(@sections_path) unless Dir.exists?(@sections_path)
  end

  def create_first_section
    @first_section_path = File.join(@sections_path, "000")
    Dir.mkdir(@first_section_path) unless Dir.exists?(@first_section_path)
  end

  def create_first_section_file
    File.open(File.join(@first_section_path, "_section.txt"), 'w') do |file|
      file.write(@resource.title)
    end
  end

  def create_first_article
    File.open(File.join(@first_section_path, "000.html"), 'w') do |file|
      file.write(%Q{
        <?xml version="1.0" encoding="UTF-8" ?>
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-BR">
          <head>
          <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
            <title>#{@resource.title}</title>
          </head>
          <body>
            #{@resource.body.sanitize.from_markdown_to_html}
            #{render_footnotes @resource.footnotes}
          </body>
        </html>
      })
    end
  end

  def default_metadata
    metadata = {
      'doc_uuid' => "kindlerb.#{@resource.id}",
      'title' => @resource.title,
      'author' => User.find_by(username: @resource.author).name,
      'date' => Time.now.strftime("%Y-%m-%d"),
      'publisher' => 'Indepedent',
      'subject' => 'Article',
      'mobi_outfile' => "#{file_name}.mobi"
    }
    metadata['masthead'] = File.join(Rails.root.to_s, 'public', @resource.kindle_cover) if @resource.kindle_cover
    metadata['cover'] = File.join(Rails.root.to_s, 'public', @resource.kindle_cover) if @resource.kindle_cover

    metadata
  end

end

