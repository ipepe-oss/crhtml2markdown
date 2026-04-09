module Crhtml2markdown
  class QConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "q"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <q> to quoted text with curly quotes
      io << "「"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "」"
    end
  end
end
