require "xml"

# Provides HTML to Markdown conversion utilities
module Crhtml2markdown
  VERSION = "0.1.0"

  # Converts the provided HTML string into Markdown.
  #
  # The initial implementation simply extracts the textual content of the
  # document. Future versions will gradually add proper Markdown conversion of
  # individual HTML elements.
  def self.convert(html : String) : String
    XML.parse_html(html).content
  end
end
