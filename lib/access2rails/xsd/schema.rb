module Access2rails::Xsd
  class Schema
    include ROXML

    xml_namespaces :od => "urn:schemas-microsoft-com:officedata", :xsd => "http://www.w3.org/2001/XMLSchema"
    xml_accessor :elements, :as => [Element], :from => "xsd:element"
  end
end
