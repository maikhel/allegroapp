class Lol


	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	LOCAL_VERSION = '1422452391'

	attr_reader :data, :item_info
	

	def initialize
		@item_info = Hash.new

		client = Savon.client(wsdl: WSDL_URL,
		 log: true,
		 log_level: :debug,
		 pretty_print_xml: true,
		 ssl_verify_mode: :none)

		xml_message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:SandboxWebApi\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:DoGetItemsListRequest>
         <urn:webapiKey>sfe724d4</urn:webapiKey>
         <urn:countryId>1</urn:countryId>
         <!--Optional:-->
         <urn:filterOptions>
            <!--Zero or more repetitions:-->
            <urn:item>
               <!--You may enter the following 3 items in any order-->
               <urn:filterId>category</urn:filterId>
               <!--Optional:-->
               <urn:filterValueId>
                  <!--Zero or more repetitions:-->
                  <urn:item>1</urn:item>
               </urn:filterValueId>
               <!--Optional:-->
              
            </urn:item>
         </urn:filterOptions>
         <!--Optional:-->
         <urn:sortOptions>
    
            <urn:sortType>endingTime</urn:sortType>
        
         </urn:sortOptions>
         <!--Optional:-->
         <urn:resultSize>50</urn:resultSize>
         
      </urn:DoGetItemsListRequest>
   </soapenv:Body>
</soapenv:Envelope>"
		

		response = client.call(:do_get_items_list, xml: xml_message)
		# {:category_id=>"26013", :category_name=>"Antyki i Sztuka", 
		# :category_parent_id=>"0", :category_items_count=>"0"}
		data = response.to_hash

		data = data[:do_get_items_list_response][:items_list][:item].first
		


		@item_info[:item_id] = data[:item_id]
		@item_info[:item_title] = data[:item_title]
		@item_info[:left_count] = data[:left_count]
		@item_info[:ending_time] = data[:ending_time]
		@item_info[:time_to_end] = data[:time_to_end]
		@item_info[:category_id] = data[:category_id]
		@item_info[:condition_info] = data[:condition_info]

		# link: nazwa + item_id
		# http://allegro.pl.webapisandbox.pl/
		#uchwyt-do-urzadzenia-mobilnego-7-10-1comfort-i5039448075.html
		# data.each do |item|

		# 	@item_info.store("item_id", item[:item_id])
			
		# end

		 ns=>"0", :country_id=>"1"}, :price_info=>{:item=>[{:price_type=>"buyNow", :price_value=>"39"}, {:price_type=>"withDelivery", :price_value=>"50"}]}, :photos_info=>{:item=>[{:photo_size=>"small", :photo_url=>"http://img02.webapisandbox.pl/photos/64x48/50/39/44/80/5039448075", :photo_is_main=>true}, {:photo_size=>"medium", :photo_url=>"http://img02.webapisandbox.pl/photos/128x96/50/39/44/80/5039448075", :photo_is_main=>true}, {:photo_size=>"large", :photo_url=>"http://img02.webapisandbox.pl/photos/400x300/50/39/44/80/5039448075", :photo_is_main=>true}]}}

		# [:categories_list][:categories_tree][:item]
		# @data = []
		# data.each do |item|
		# 	@data << item[:category_name]
		# 	@data << item[:category_items_count]
		# end
		

		@data = @item_info

		# data = response.to_array(:do_query_sys_status_response).first
		# local_version = data[:ver_key]


	end


end
