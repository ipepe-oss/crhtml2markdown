module Crhtml2markdown
  class BlockContainerConverter < ElementConverter
    BLOCK_CONTAINERS = Set{
      "div", "section", "article", "nav", "header",
      "footer", "main", "aside", "address",
    }

    def handles?(node : XML::Node) : Bool
      BLOCK_CONTAINERS.includes?(node.name)
    end

    def convert(node : XML::Node, io : IO) : Nil
      inner = String.build do |inner_io|
        node.children.each { |child| Crhtml2markdown.convert_node(child, inner_io) }
      end.strip
      return if inner.empty?
      io << inner << "\n\n"
    end
  end
end
