module Crhtml2markdown
  class AcronymConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "acronym"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <acronym title="...">content</acronym> to "content (title)"
      # Similar to how abbr is handled
      title = node["title"]?

      # Output the content
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }

      # Add the title in parentheses if available
      if title && !title.empty?
        io << " ("
        io << title
        io << ")"
      end
    end
  end
end
