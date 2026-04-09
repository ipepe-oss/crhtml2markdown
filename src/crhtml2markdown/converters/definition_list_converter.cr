module Crhtml2markdown
  class DefinitionListConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "dl"
    end

    def convert(node : XML::Node, io : IO) : Nil
      first_term = true
      node.children.each do |child|
        case child.name
        when "dt"
          io << "\n" unless first_term
          first_term = false
          text = String.build do |inner|
            child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
          end.strip
          io << text << "\n"
        when "dd"
          text = String.build do |inner|
            child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
          end.strip
          io << ": " << text << "\n"
        end
      end
      io << "\n"
    end
  end
end
