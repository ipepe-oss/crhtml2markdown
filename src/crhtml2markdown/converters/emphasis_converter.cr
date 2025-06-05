module Crhtml2markdown
  class EmphasisConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "em" || node.name == "strong"
    end

    def convert(node : XML::Node, io : IO) : Nil
      marker = node.name == "strong" ? "**" : "*"
      io << marker
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << marker
    end
  end
end
