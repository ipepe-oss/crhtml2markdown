module Crhtml2markdown
  class BidiConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "bdi" || node.name == "bdo"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For bidirectional text elements, just output the text
      # Direction information is lost in markdown
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
