# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  birthday   :date
#  city       :string
#  country    :string
#  age        :integer
#  gender     :string
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
