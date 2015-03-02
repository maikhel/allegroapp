class SoapConnection


	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	@@local_version = '1422452391'
	@@country_id = 1
	@@session_handle = 0
	@@webapikey = 'sfe724d4'
	
	##{ENV["WEBAPIKEY"]}
	##{ENV["USER_PASSWORD"]}
	##{ENV["USER_LOGIN"]}
	attr_reader :data

	def initialize
		@client = Savon.client(
			wsdl: WSDL_URL,
			log: true,
		 	log_level: :debug,
		 	pretty_print_xml: true,
		 	ssl_verify_mode: :none) #none only for dev environment!!!)
		

	end

	def take_categories
		message = {"countryId" => 1, "webapiKey" => @@webapikey}
		response = @client.call(:do_get_cats_data, message: message)
		@data = response.to_hash
	end


	def login
		xml_message = ""
		@client.call(:do_login, xml: xml_message)

	end


	def 
	def take_new_local_version

		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"
					 xmlns:urn=\"urn:SandboxWebApi\">
		   <soapenv:Header/>
		   <soapenv:Body>
		      <urn:DoQuerySysStatusRequest>
		         <urn:sysvar>4</urn:sysvar>
		         <urn:countryId>1</urn:countryId>
		         <urn:webapiKey>#{ENV["WEBAPIKEY"]}</urn:webapiKey>
		      </urn:DoQuerySysStatusRequest>
		   </soapenv:Body>
		</soapenv:Envelope>"

		response = @client.call(:do_query_sys_status, xml: xml_message)

		data = response.to_array(:do_query_sys_status_response).first
		@@local_version = data[:ver_key]

	end



end



