module Crhtml2markdown
  class BlockquoteConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "blockquote"
    end

    def convert(node : XML::Node, io : IO) : Nil
      inner = String.build do |inner_io|
        node.children.each { |child| Crhtml2markdown.convert_node(child, inner_io) }
      end.strip
      inner.each_line(chomp: false) do |line|
        io << "> " << line
      end
      io << "\n\n"
    end
  end
end
