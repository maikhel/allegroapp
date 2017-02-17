# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  price       :decimal(10, )
#  ending_time :date
#  thumb_url   :string(255)
#  link        :string(255)
#  allegro_id  :decimal(10, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base


end
