require 'xmlsimple' unless defined? XmlSimple

class EfaxReply
  attr_accessor :xml
  
  def initialize(params)
    self.xml = XmlSimple.xml_in(params)
  end
  
  def [](key)
    self.xml.send :[], key
  end
  
  def authorized?
    self["Password"] == CuisineLibrary::Efax.password && self["UserName"] == CuisineLibrary::Efax.username
  end
  
  def success?
    self["FaxStatus"] == "0"
  end
end