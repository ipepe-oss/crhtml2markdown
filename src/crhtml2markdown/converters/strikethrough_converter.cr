module Crhtml2markdown
  class StrikethroughConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "del" || node.name == "s"
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "~~"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "~~"
    end
  end
end
