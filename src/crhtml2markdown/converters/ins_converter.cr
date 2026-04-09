module Crhtml2markdown
  class InsConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "ins"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert <ins> to ++inserted++ format (CommonMark extension)
      io << "++"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "++"
    end
  end
end
