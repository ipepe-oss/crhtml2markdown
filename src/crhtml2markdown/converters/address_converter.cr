module Crhtml2markdown
  class AddressConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "address"
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "\n"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "\n"
    end
  end
end
