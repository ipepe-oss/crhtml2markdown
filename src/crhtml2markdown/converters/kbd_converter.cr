module Crhtml2markdown
  class KbdConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "kbd"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <kbd> to inline code format
      io << "`"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "`"
    end
  end
end
