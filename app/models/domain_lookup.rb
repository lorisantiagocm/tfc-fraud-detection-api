class DomainLookup < ActiveRecord::Base
  belongs_to :whois_information, optional: true
  belongs_to :domain, optional: true
end
