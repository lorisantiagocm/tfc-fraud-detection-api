class DomainLookupSerializer < ActiveModel::Serializer
  attributes :id, :warnings, :domain, :whois_information
end
