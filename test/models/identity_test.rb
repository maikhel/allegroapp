# == Schema Information
#
# Table name: identities
#
#  id               :integer          not null, primary key
#  uid              :string(255)
#  provider         :string(255)
#  user_id          :integer
#  token            :string(255)
#  token_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
