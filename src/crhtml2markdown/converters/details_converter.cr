module Crhtml2markdown
  class DetailsConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "details"
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "\n<details>\n"
      node.children.each do |child|
        if child.name == "summary"
          summary_text = String.build do |inner|
            child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
          end.strip
          io << "<summary>" << summary_text << "</summary>\n\n"
        else
          Crhtml2markdown.convert_node(child, io)
        end
      end
      io << "\n</details>\n\n"
    end
  end
end
