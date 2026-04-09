module Crhtml2markdown
  class MarkConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "mark"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <mark> to ==highlighted== format (CommonMark extension)
      io << "=="
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "=="
    end
  end
end
