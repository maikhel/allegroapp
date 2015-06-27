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

class Item < ActiveRecord::Base


end
