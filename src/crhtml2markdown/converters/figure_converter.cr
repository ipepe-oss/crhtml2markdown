module Crhtml2markdown
  class FigureConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "figure"
    end

    def convert(node : XML::Node, io : IO) : Nil
      node.children.each do |child|
        case child.name
        when "figcaption"
          caption = String.build do |inner|
            child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
          end.strip
          io << "\n*" << caption << "*\n"
        else
          Crhtml2markdown.convert_node(child, io)
        end
      end
      io << "\n"
    end
  end
end
