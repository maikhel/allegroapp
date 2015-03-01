class Product
	
	##{ENV["WEBAPIKEY"]}
	
	
	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	attr_reader :it_id, :name, :ItBuyNowPrice, :ItCity, :data
	
	def initialize
		
		client = Savon.client(wsdl: WSDL_URL,
		 log: true,
		 log_level: :debug,
		 pretty_print_xml: true,
		 ssl_verify_mode: :none) #none only for dev environment!!!
		login_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"
		 xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoLoginRequest>
         <urn:userLogin>Maik345</urn:userLogin>
         <urn:userPassword>fe724d40056bfd68 </urn:userPassword>
         <urn:countryCode>1</urn:countryCode>
         <urn:webapiKey>#{ENV["WEBAPIKEY"]}</urn:webapiKey>
         <urn:localVersion>1422452391</urn:localVersion>
      </urn:DoLoginRequest>
   </soapenv:Body>
</soapenv:Envelope>"
		client.call(:do_login, )		
		
		
		#xml_message = {"countryCode" => '1', "webapiKey" => "sfe724d4"}
		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoGetItemsListRequest>
         <urn:webapiKey>#{ENV["WEBAPIKEY"]}</urn:webapiKey>
         <urn:countryId>1</urn:countryId>
      </urn:DoGetItemsListRequest>
   </soapenv:Body>
</soapenv:Envelope>"
		

		response = client.call(:do_get_items_list, xml: xml_message)
		@data = response.to_xml
		if data.nil?
			puts "DATA JEST"

		end



# 		response = client.call(:do_get_countries, xml: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
#    <soapenv:Header/>
#    <soapenv:Body>
#       <urn:DoGetCountriesRequest>
#          <urn:countryCode>1</urn:countryCode>
#          <urn:webapiKey>#{ENV["WEBAPIKEY"]}</urn:webapiKey>
#       </urn:DoGetCountriesRequest>
#    </soapenv:Body>
# </soapenv:Envelope>")
		
		#response = client.call(:do_show_item_info_ext, message: {"sessionHandle" => 'eba5e813c25a50b40039d746d7b0ccc3c32745010bcc68me00_1',"itemId" => 5039456794})

	
		
      		# data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
		      # if data
		      #   @state = data[:state]
		      #   @city = data[:city]
		      #   @area_code = data[:area_code]
		      #   @time_zone = data[:time_zone]
		      # end
		
  	end
end



