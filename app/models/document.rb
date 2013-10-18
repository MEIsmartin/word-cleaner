class Document < ActiveRecord::Base

  validates :original, :title, presence: true

  default_scope { order('updated_at') }

  before_save :clean_body

private

  def clean(body)
    clean = body
    clean = clean.gsub('”', '"')
    clean = clean.gsub('“', '"')
    clean = clean.gsub('’', "'")
    clean = clean.gsub('—', "&mdash;")
    clean = clean.gsub('–', "&ndash;")
    clean = clean.gsub('…', '...')
    clean = clean.gsub('  ', ' ')
    clean = clean.gsub("\r\n\r\n", "</p><p>")
    clean = clean.gsub("\r\n \r\n", "</p><p>")
    clean = clean.gsub("\r\n", "</p><p>")
    clean = "<p>#{clean}</p>"
    clean = clean.gsub(' </p>', '</p>')
    clean = clean.gsub("</p><p>", "</p>\r\n<p>")
    clean = clean.gsub("<p></p>", '')
    clean = clean.gsub(/<p>•\t([\w\s"\(\)\\\.\-,\$:']+)<\/p>/i, '<li>\1</li>')
    clean = clean.gsub(/<p>\d\.\t([\w\s\\\(\)\/.,;&"':\$-]+)<\/p>/i, '<li>\1</li>')
    clean
  end

  def clean_body
    self.cleaned = clean(self.original)
  end
end
