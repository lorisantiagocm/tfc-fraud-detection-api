# == Schema Information
#
# Table name: domains
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  trusted         :boolean          default("false"), not null
#  searched_amount :integer          default("0"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Domain < ActiveRecord::Base
  has_many :whois_informations

  validates :name, presence: true
end
