class WhoisInformation::Analyze::BreakDownDomain < Micro::Case
  attributes :searched_url

  def call!
    uri = URI.parse(searched_url)

    protocol = uri.scheme         # "https"
    domain = uri.host             # "dev.to"
    # port = uri.port               # nil (default port for https is used)
    # path = uri.path               # "/risafj/the-basics-of-rails-i18n-translate-errors-models-and-attributes-84d"
    # query = uri.query             # nil (no query parameters)
    # fragment = uri.fragment       # nil (no fragment)

    parsed_domain = PublicSuffix.parse(domain, ignore_private: true)

    Success result: {
      domain_name: domain&.downcase,
      protocol: protocol&.downcase,
      top_level_domain: parsed_domain.tld&.downcase,
      third_level_domain: parsed_domain.trd&.downcase,
      port: uri.port,
      whois_formatted_domain: [ parsed_domain.sld, parsed_domain.tld ].join(".")
    }
  end
end
