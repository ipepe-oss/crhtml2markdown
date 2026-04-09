require "xml"

require "./crhtml2markdown/converters/element_converter"
require "./crhtml2markdown/converters/heading_converter"
require "./crhtml2markdown/converters/paragraph_converter"
require "./crhtml2markdown/converters/emphasis_converter"
require "./crhtml2markdown/converters/link_converter"
require "./crhtml2markdown/converters/text_converter"
require "./crhtml2markdown/converters/code_converter"
require "./crhtml2markdown/converters/horizontal_rule_converter"
require "./crhtml2markdown/converters/list_converter"
require "./crhtml2markdown/converters/blockquote_converter"
require "./crhtml2markdown/converters/image_converter"
require "./crhtml2markdown/converters/strikethrough_converter"
require "./crhtml2markdown/converters/table_converter"
require "./crhtml2markdown/converters/line_break_converter"
require "./crhtml2markdown/converters/checkbox_converter"
require "./crhtml2markdown/converters/definition_list_converter"
require "./crhtml2markdown/converters/sub_sup_converter"
require "./crhtml2markdown/converters/inline_html_passthrough_converter"
require "./crhtml2markdown/converters/details_converter"
require "./crhtml2markdown/converters/figure_converter"
require "./crhtml2markdown/converters/block_container_converter"
require "./crhtml2markdown/converters/media_converter"
require "./crhtml2markdown/converters/q_converter"

# TODO: Write documentation for `Crhtml2markdown`
module Crhtml2markdown
  VERSION = "0.1.0"

  @@converters = [
    CodeConverter.new,
    HeadingConverter.new,
    HorizontalRuleConverter.new,
    TableConverter.new,
    ListConverter.new,
    BlockquoteConverter.new,
    ImageConverter.new,
    CheckboxConverter.new,
    LineBreakConverter.new,
    DefinitionListConverter.new,
    SubSupConverter.new,
    InlineHtmlPassthroughConverter.new,
    DetailsConverter.new,
    FigureConverter.new,
    MediaConverter.new,
    BlockContainerConverter.new,
    StrikethroughConverter.new,
    ParagraphConverter.new,
    EmphasisConverter.new,
    LinkConverter.new,
    QConverter.new,
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

  BLOCK_ELEMENTS = Set{
    "p", "pre", "h1", "h2", "h3", "h4", "h5", "h6", "hr",
    "ul", "ol", "blockquote", "table", "dl", "details", "figure",
    "div", "section", "article", "nav", "header", "footer",
    "main", "aside", "address", "video", "audio",
  }

  def self.convert_node(node : XML::Node, io : IO)
    if converter = @@converters.find(&.handles?(node))
      converter.convert(node, io)
    else
      prev_was_inline = false
      node.children.each do |child|
        # Add spacing before block elements when preceded by an inline sibling
        if BLOCK_ELEMENTS.includes?(child.name) && prev_was_inline
          io << "\n\n"
        end
        convert_node child, io
        if child.text?
          prev_was_inline = !child.content.strip.empty?
        elsif BLOCK_ELEMENTS.includes?(child.name)
          prev_was_inline = false
        else
          prev_was_inline = true
        end
      end
    end
  end
end
