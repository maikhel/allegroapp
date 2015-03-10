class SoapConnection

	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	@@webapikey = ''
	@@user_login = ''
	@@user_password =Base64.encode64(Digest::SHA256.new.digest(""))
	@@api_namespace = "xmlns:urn=\"urn:SandboxWebApi\""
	@@nam = "urn:"

	#uncomment this to have real allegro
	# WSDL_URL = 'https://webapi.allegro.pl/service.php?wsdl'
	# @@webapikey = 'yourwebapikey'
	# @@user_login = 'yourlogin'
	# @@user_password =Base64.encode64(Digest::SHA256.new.digest("yourpassword")
	# @@api_namespace = "xmlns:ser=\"https://webapi.allegro.pl/service.php\""
	# @@nam = "ser:"
	
	


	@@local_version = '1422452391'
	@@country_id = 1 #Poland
	@@session_handle = 0
	



	attr_reader :data, :items, :categories

	def initialize
		@client = Savon.client(
			wsdl: WSDL_URL,
			log: true,
		 	log_level: :debug,
		 	pretty_print_xml: true,
		 	strip_namespaces: true,
		 	ssl_verify_mode: :none) #none only for dev environment!!!)
		self.take_new_local_version
		self.login

		@categories = {"Elektronika" => 10, "Moda i uroda" => 250152, "Dom i zdrowie" =>79197,
		"Dziecko" => 250145, "Kultura i rozrywka" => 262, "Sport i wypoczynek" => 3919,
		"Motoryzacja" => 3, "Kolekcje i sztuka" => 105417, "Firma i usługi" => 105414, 
		"Strefa okazji"=>98316, "Wszystko" => 0}

	end

	def call(operation_name, locals= {})
		@client.call(operation_name, locals)
	end

	def take_categories
		message = {"countryId" => 1, "webapiKey" => @@webapikey}
		response = @client.call(:do_get_cats_data, message: message).body
		@data = response.to_hash
	end


	def login
		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"
		 #{@@api_namespace}>
   <soapenv:Header/>
   <soapenv:Body>
      <#{@@nam}DoLoginEncRequest>
         <#{@@nam}userLogin>#{@@user_login}</#{@@nam}userLogin>
         <#{@@nam}userHashPassword>#{@@user_password}</#{@@nam}userHashPassword>
         <#{@@nam}countryCode>1</#{@@nam}countryCode>
         <#{@@nam}webapiKey>#{@@webapikey}</#{@@nam}webapiKey>
         <#{@@nam}localVersion>#{@@local_version}</#{@@nam}localVersion>
      </#{@@nam}DoLoginEncRequest>
   </soapenv:Body>
</soapenv:Envelope>"

		
		response = @client.call(:do_login_enc, xml: xml_message)
		@@session_handle = response.to_hash[:do_login_enc_response][:session_handle_part]

	end


	def search(item, category_num,order)
		
		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"
		 #{@@api_namespace}>
   <soapenv:Header/>
   <soapenv:Body>
      <#{@@nam}DoSearchRequest>
         <#{@@nam}sessionHandle>#{@@session_handle}</#{@@nam}sessionHandle>
         <#{@@nam}searchQuery>
            <#{@@nam}searchString>#{item}</#{@@nam}searchString>
            <#{@@nam}searchOrder>#{order}</#{@@nam}searchOrder>
            <#{@@nam}searchCategory>#{category_num}</#{@@nam}searchCategory>
            <#{@@nam}searchLimit>100</#{@@nam}searchLimit>
         </#{@@nam}searchQuery>
      </#{@@nam}DoSearchRequest>
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
					 #{@@api_namespace}>
		   <soapenv:Header/>
		   <soapenv:Body>
		      <#{@@nam}DoQuerySysStatusRequest>
		         <#{@@nam}sysvar>4</#{@@nam}sysvar>
		         <#{@@nam}countryId>1</#{@@nam}countryId>
		         <#{@@nam}webapiKey>#{@@webapikey}</#{@@nam}webapiKey>
		      </#{@@nam}DoQuerySysStatusRequest>
		   </soapenv:Body>
		</soapenv:Envelope>"


		#message = {sysvar: 4, countryId: 1, webapikey: @@webapikey}
		#response = @client.call(:do_query_sys_status, message: message)
		response = @client.call(:do_query_sys_status, xml: xml_message)

		data = response.to_array(:do_query_sys_status_response).first
		@@local_version = data[:ver_key]

	end



end





 

