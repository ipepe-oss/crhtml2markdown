module Crhtml2markdown
  class SmallConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "small"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Pass through as HTML since markdown has no small text equivalent
      io << "<small>"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</small>"
    end
  end
end
