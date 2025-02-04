class DomainLookupSerializer < ActiveModel::Serializer
  attributes :id, :domain, :whois_information
end
