module Crhtml2markdown
  class CiteDfnConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "cite" || node.name == "dfn"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <cite> and <dfn> to italics
      io << "*"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "*"
    end
  end
end
