class Product

	attr_reader :name, :price, :ending_time, :categories, :thumb_url, :link, :allegro_id

  	def initialize(id, name, price, ending_time, thumb_url)

  		@allegro_id = id
  		@name = name
  		@price = price

      if ending_time.to_i == 0
        @ending_time = "no time limit"
      else
  		  @ending_time = Time.at(ending_time.to_i)
      end

  		@thumb_url = thumb_url
      name_link = name.tr(' ','-')
      name_link = name_link.tr('.', '-')
      @link = "http://www.allegro.pl/"+name_link.downcase + "-i" + id +".html"

  	end

    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash
    end

end

