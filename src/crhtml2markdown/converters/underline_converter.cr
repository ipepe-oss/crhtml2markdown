module Crhtml2markdown
  class UnderlineConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "u"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Pass through as HTML since markdown has no underline equivalent
      io << "<u>"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</u>"
    end
  end
end
