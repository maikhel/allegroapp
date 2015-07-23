# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :decimal(, )
#  ending_time :date
#  thumb_url   :string
#  link        :string
#  allegro_id  :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Item do
  it "is valid with all properties" do 
   expect(create(:item)).to be_valid
  end


end
