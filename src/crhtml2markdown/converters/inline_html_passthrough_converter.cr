module Crhtml2markdown
  class InlineHtmlPassthroughConverter < ElementConverter
    PASSTHROUGH_TAGS = Set{"mark", "kbd", "ins", "u", "small", "abbr"}

    def handles?(node : XML::Node) : Bool
      PASSTHROUGH_TAGS.includes?(node.name)
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "<" << node.name
      node.attributes.each do |attr|
        io << " " << attr.name << "=\"" << attr.content << "\""
      end
      io << ">"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</" << node.name << ">"
    end
  end
end
