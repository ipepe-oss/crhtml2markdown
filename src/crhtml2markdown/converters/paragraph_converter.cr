module Crhtml2markdown
  class ParagraphConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "p"
    end

    def convert(node : XML::Node, io : IO) : Nil
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "\n\n"
    end
  end
end
