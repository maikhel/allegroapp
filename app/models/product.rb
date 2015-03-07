class Product
	
	attr_reader :name, :price, :ending_time, :categories, :thumb_url

	

  	def initialize(id, name, price, ending_time, thumb_url)

  		@id = id
  		@name = name
  		@price = price
  		@ending_time = Time.at(ending_time.to_i)
  		@thumb_url = thumb_url

  	end




end

