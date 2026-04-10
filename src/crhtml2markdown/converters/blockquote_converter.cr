module Crhtml2markdown
  class BlockquoteConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "blockquote"
    end

    def convert(node : XML::Node, io : IO) : Nil
      inner = String.build do |inner_io|
        node.children.each { |child| Crhtml2markdown.convert_node(child, inner_io) }
      end.strip
      inner.each_line do |line|
        if line.empty?
          io << ">\n"
        else
          io << "> " << line << "\n"
        end
      end
      io << "\n"
    end
  end
end
