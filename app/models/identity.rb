# == Schema Information
#
# Table name: identities
#
#  id               :integer          not null, primary key
#  uid              :string
#  provider         :string
#  user_id          :integer
#  token            :string
#  token_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Identity < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider

	def self.find_for_oauth(auth)
		find_or_create_by(uid: auth.uid, provider: auth.provider)
	end

	def token_expired?
		expires = self.token_expires_at

		if expires and expires == Time.at(0)
			false
		else
			Time.now > expires
		end
		

	end


end
