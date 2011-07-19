require 'net/https'
require 'open-uri'
require 'base64'
require 'cgi'

module CuisineLibrary
  class Efax
    cattr_accessor :username, :password, :account_id, :debugging_phone
    
    def self.send_fax(company, phone, text, callback, transmission_id = "0")
      phone = debugging_phone if debugging_phone
      
      xml = <<-END
<?xml version=\"1.0\"?>
      <OutboundRequest>
        <AccessControl>
          <UserName>#{username}</UserName>
          <Password>#{password}</Password>
        </AccessControl>
        <Transmission>
          <TransmissionControl>
            <TransmissionID>#{transmission_id}</TransmissionID>
            <Resolution>STANDARD</Resolution>
            <Priority>NORMAL</Priority>
            <SelfBusy>ENABLE</SelfBusy>
            <FaxHeader>\"@DATE1 @TIME3 @ROUTETO{26} @RCVRFAX Pg%P/@TPAGES\"</FaxHeader>
          </TransmissionControl>
          <DispositionControl>
            <DispositionURL>#{callback}</DispositionURL>
            <DispositionLevel>BOTH</DispositionLevel>
            <DispositionMethod>POST</DispositionMethod>
            <DispositionEmails>
             <DispositionEmail>
               <DispositionRecipient>Maurycy Pawlowski-Wieronski</DispositionRecipient>
               <DispositionAddress>maurycypw@gmail.com</DispositionAddress>
             </DispositionEmail>
             <DispositionEmail>
               <DispositionRecipient>Jason Strutz</DispositionRecipient>
               <DispositionAddress>jason@exchangehut.com</DispositionAddress>
             </DispositionEmail>
            </DispositionEmails>
          </DispositionControl>
          <Recipients>
            <Recipient>
              <RecipientName></RecipientName>
              <RecipientCompany>#{company}</RecipientCompany>
              <RecipientFax>#{phone}</RecipientFax>
            </Recipient>
          </Recipients>
          <Files>
            <File>
              <FileContents>#{Base64.encode64(text)}</FileContents>
              <FileType>doc</FileType>
            </File>
          </Files>
        </Transmission>
      </OutboundRequest>
      END
      
      url = URI.parse('https://secure.efaxdeveloper.com/EFax_WebFax.serv')

      req = Net::HTTP::Post.new(url.path)
      req.set_form_data({ 'id' => account_id.to_s, 'xxml' => xml, 'respond' => "XML" })

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.start { |http| http.request(req) }
    end
  end
end

if false
  CuisineLibrary::Efax.username = 'strutz'
  CuisineLibrary::Efax.password = 'jason'
  CuisineLibrary::Efax.account_id = 8003812214
  
  puts CuisineLibrary::Efax.send_fax('some name', 'some company', '6088314760', 'whatever').body
end