module Crhtml2markdown
  class TimeDataConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "time" || node.name == "data"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For time and data elements, just output the text content
      # The machine-readable value is lost in markdown conversion
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
