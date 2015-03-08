class Product
	
	attr_reader :name, :price, :ending_time, :categories, :thumb_url, :link

	

  	def initialize(id, name, price, ending_time, thumb_url)

  		@id = id
  		@name = name
  		@price = price
  		@ending_time = Time.at(ending_time.to_i)
  		@thumb_url = thumb_url
      name_link = name.tr(' ','-')
      name_link = name_link.tr('.', '-')
      @link = "http://www.allegro.pl/"+name_link.downcase + "-i" + id +".html"

  	end




end

