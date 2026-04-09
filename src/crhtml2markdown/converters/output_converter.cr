module Crhtml2markdown
  class OutputConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "output"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For output elements, just output the text content
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
