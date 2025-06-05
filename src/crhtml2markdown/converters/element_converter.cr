module Crhtml2markdown
  abstract class ElementConverter
    abstract def handles?(node : XML::Node) : Bool
    abstract def convert(node : XML::Node, io : IO) : Nil
  end
end
