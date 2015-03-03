class SoapConnection


	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	@@local_version = '1422452391'
	@@country_id = 1
	@@session_handle = 0
	@@webapikey = 'sfe724d4'
	@@user_login = 'Maik345'
	@@user_password ="fe724d40056bfd68"
	##{ENV["WEBAPIKEY"]}
	##{ENV["USER_PASSWORD"]}
	##{ENV["USER_LOGIN"]}



	attr_reader :data, :items

	def initialize
		@client = Savon.client(
			wsdl: WSDL_URL,
			log: true,
		 	log_level: :debug,
		 	pretty_print_xml: true,
		 	strip_namespaces: true,
		 	ssl_verify_mode: :none) #none only for dev environment!!!)
		

	end

	def take_categories
		message = {"countryId" => 1, "webapiKey" => @@webapikey}
		response = @client.call(:do_get_cats_data, message: message).body
		@data = response.to_hash
	end


	def login
		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoLoginRequest>
         <urn:userLogin>#{@@user_login}</urn:userLogin>
         <urn:userPassword>#{@@user_password}</urn:userPassword>
         <urn:countryCode>1</urn:countryCode>
         <urn:webapiKey>#{@@webapikey}</urn:webapiKey>
         <urn:localVersion>#{@@local_version}</urn:localVersion>
      </urn:DoLoginRequest>
   </soapenv:Body>
</soapenv:Envelope>"

		
		response = @client.call(:do_login, xml: xml_message)
		@@session_handle = response.to_hash[:do_login_response][:session_handle_part]

	end

	def search(item)

		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoSearchRequest>
         <urn:sessionHandle>#{@@session_handle}</urn:sessionHandle>
         <urn:searchQuery>
            <urn:searchString>#{item}</urn:searchString>
         </urn:searchQuery>
      </urn:DoSearchRequest>
   </soapenv:Body>
</soapenv:Envelope>"
		# begin
		# 	response = @client.call(:do_search, xml: xml_message)
		# rescue ERR_NO_SESSION => e
		# 	self.login
		# end
		#message = {"sessionHandle"=> @@session_handle, "searchString" => item}

		response = @client.call(:do_search, xml: xml_message)	
		@items = []
		
			begin
				products = response.to_hash[:do_search_response][:search_array][:item]
				products.each do |product|
					@items << Product.new(product[:s_it_id],product[:s_it_name],
						product[:s_it_price],product[:s_it_ending_time],
						product[:s_it_thumb_url])
				end
				@data = @items
			rescue Exception => e
				@data = @items
			end
			
				@data = @items
			
			


		
	end
	
	
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



