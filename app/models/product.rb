class Product
	
	
	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	attr_reader :it_id, :name, :ItBuyNowPrice, :ItCity
	
	def initialize
		
		client = Savon.client(wsdl: WSDL_URL,
		 log: true,
		 log_level: :debug,
		 pretty_print_xml: true,
		 ssl_verify_mode: :none) #none only for dev environment!!!

		# client = Savon.client(
		# 	log: true,
		# 	log_level: :debug,
		# 	pretty_print_xml: true,
  # 			#:wsdl => 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl',
  # 			:ssl_verify_mode => :none,
  # 			:endpoint => 'https://webapi.allegro.pl.webapisandbox.pl/service.php',
  # 			:namespace => "urn:SandboxWebApi")

		countryCode = ARGV[0] || '1'
		webapiKey = ARGV[0] || "sfe724d4"
		
		xml_message = {"countryCode" => '1', "webapiKey" => "sfe724d4"}

		response = client.call(:do_get_countries, xml: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoGetCountriesRequest>
         <urn:countryCode>1</urn:countryCode>
         <urn:webapiKey>#{ENV["WEBAPIKEY"]}</urn:webapiKey>
      </urn:DoGetCountriesRequest>
   </soapenv:Body>
</soapenv:Envelope>")
		# response = client.call(:do_show_item_info_ext, message: {"sessionHandle" => 'eba5e813c25a50b40039d746d7b0ccc3c32745010bcc68me00_1',"itemId" => 5039456794})

		
		
		
		
      		# data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
		      # if data
		      #   @state = data[:state]
		      #   @city = data[:city]
		      #   @area_code = data[:area_code]
		      #   @time_zone = data[:time_zone]
		      # end
		
  	end
end



