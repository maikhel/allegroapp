# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  birthday   :date
#  city       :string(255)
#  country    :string(255)
#  age        :integer
#  gender     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
