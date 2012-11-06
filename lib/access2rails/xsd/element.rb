module Access2rails::Xsd
  class Element
    include ROXML

    xml_accessor :name, :from => "@name"
  end
end
