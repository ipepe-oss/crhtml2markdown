module Crhtml2markdown
  class SmallConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "small"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <small> to just the text (markdown has no small text equivalent)
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
