module Crhtml2markdown
  class AbbrConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "abbr"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For abbreviations, output the text with title in parentheses if available
      title = node["title"]?

      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }

      # Add title in parentheses if present
      if title && !title.empty?
        io << " (" << title << ")"
      end
    end
  end
end
