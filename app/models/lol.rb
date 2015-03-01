class Lol


	WSDL_URL = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
	LOCAL_VERSION = '1422452391'

	attr_reader :data

	def initialize


		client = Savon.client(wsdl: WSDL_URL,
		 log: true,
		 log_level: :debug,
		 pretty_print_xml: true,
		 ssl_verify_mode: :none)

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

		response = client.call(:do_query_sys_status, xml: xml_message)

		data = response.to_array(:do_query_sys_status_response).first
		local_version = data[:ver_key]


	end


end
