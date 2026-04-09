module Crhtml2markdown
  class TemplateConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "template"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Template content should not be rendered
      # Do nothing - skip the template element entirely
    end
  end
end
