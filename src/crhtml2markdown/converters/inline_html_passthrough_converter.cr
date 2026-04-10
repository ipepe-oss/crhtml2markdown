module Crhtml2markdown
  class InlineHtmlPassthroughConverter < ElementConverter
    PASSTHROUGH_TAGS = Set{
      "wbr",     # Word break opportunity
      "rt",      # Ruby text
      "rp",      # Ruby parenthesis
      "acronym", # Acronym (deprecated but still used)
    }

    def handles?(node : XML::Node) : Bool
      PASSTHROUGH_TAGS.includes?(node.name)
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "<" << node.name
      node.attributes.each do |attr|
        escaped_content = attr.content.gsub('"', "&quot;")
        io << " " << attr.name << "=\"" << escaped_content << "\""
      end
      io << ">"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</" << node.name << ">"
    end
  end
end
