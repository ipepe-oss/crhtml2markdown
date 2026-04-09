module Crhtml2markdown
  class MediaConverter < ElementConverter
    MEDIA_TAGS = Set{"video", "audio"}

    def handles?(node : XML::Node) : Bool
      MEDIA_TAGS.includes?(node.name)
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << node.to_xml.strip << "\n\n"
    end
  end
end
