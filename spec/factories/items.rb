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

FactoryGirl.define do
  factory :item do
    name "Item name"
    price 9.99
    ending_time "2015-12-16 15:53:41"
    allegro_id 23423423423
  end
end