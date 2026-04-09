module Crhtml2markdown
  class UnderlineConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "u"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <u> to just the text (markdown has no underline equivalent)
      # Note: Some implementations use __text__ for underline, but this conflicts with bold
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
