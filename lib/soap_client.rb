class SoapClient

	attr_reader :data, :items, :categories, :response
	attr_reader :web_api_key, :country_code, :api_version

	def initialize
		@graph = Savon.client(
			wsdl: ENV['WSDL_URL'],
			log: true,
		 	log_level: :debug,
		 	pretty_print_xml: true,
		 	strip_namespaces: true
		)
	  @web_api_key = ENV['WEB_API_KEY']
	  @country_code = 1 #Poland

		# @categories = {"Elektronika" => 10, "Moda i uroda" => 250152, "Dom i zdrowie" =>79197,
		# "Dziecko" => 250145, "Kultura i rozrywka" => 262, "Sport i wypoczynek" => 3919,
		# "Motoryzacja" => 3, "Kolekcje i sztuka" => 105417, "Firma i usługi" => 105414, 
		# "Strefa okazji"=>98316, "Wszystko" => 0}
	end

	def get_api_version
		message = {sysvar: 4, countryId: country_code, webapiKey: web_api_key}
		response = @graph.call(:do_query_sys_status, message: message).body
	  response[:do_query_sys_status_response][:ver_key]
	end

	def get_categories_version
		message = { countryCode: country_code, webapiKey: web_api_key}
		@response = @graph.call(:do_get_cats_data, message: message).body
	end

	def login
	  @api_version = get_api_version
	  user_password = Base64.encode64(Digest::SHA256.new.digest(ENV['USER_PASSWORD']))
	  message = { 
	  	userLogin: ENV['USER_LOGIN'],
	  	userHashPassword: user_password,
	  	countryCode: country_code,
	  	webapiKey: web_api_key,
	  	localVersion: api_version
	  }
		response = @graph.call(:do_login_enc, message: message).body
		@user_id = response[:do_login_enc_response][:user_id]
		@session_handle = response[:do_login_enc_response][:session_handle_part]
	end


	def search(item, category, order = "endingTime")

		message = {
			webapiKey: web_api_key,
			countryId: country_code,
			sortOptions: {sortType: order},
			filterOptions: {filterId: 'category'},
			resultSize: 10
		}
		
		response = @graph.call(:do_search, xml: xml_message)	
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

end





 

