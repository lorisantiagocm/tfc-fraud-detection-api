# == Schema Information
#
# Table name: whois_informations
#
#  id                 :integer          not null, primary key
#  owner_name         :string
#  owner_email        :string
#  registered_at      :date
#  iana_id            :string
#  owner_phone_number :string
#  last_updated_at    :date
#  expires_at         :date
#  name_servers       :string
#  whois_server       :string
#  domain_statuses    :string
#  domain_id          :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class WhoisInformation < ActiveRecord::Base
  belongs_to :domain
end
