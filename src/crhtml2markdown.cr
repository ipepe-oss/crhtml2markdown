require "xml"

require "./crhtml2markdown/converters/element_converter"
require "./crhtml2markdown/converters/heading_converter"
require "./crhtml2markdown/converters/text_converter"

# TODO: Write documentation for `Crhtml2markdown`
module Crhtml2markdown
  VERSION = "0.1.0"

  @@converters = [
    HeadingConverter.new,
    TextConverter.new,
  ]

  # Converts the provided HTML string into Markdown.
  #
  # Individual HTML elements are handled by dedicated converter classes.
  # Currently only headings (`h1`-`h6`) and plain text nodes are supported.
  def self.convert(html : String) : String
    doc = XML.parse_html(html)
    body = doc.xpath_node("//body") || doc

    String.build do |io|
      convert_node body, io
    end.strip
  end

  private def self.convert_node(node : XML::Node, io : IO)
    if converter = @@converters.find(&.handles?(node))
      converter.convert(node, io)
    else
      node.children.each { |child| convert_node child, io }
    end
  end
end
