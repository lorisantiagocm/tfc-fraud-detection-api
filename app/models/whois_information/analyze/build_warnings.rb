class WhoisInformation::Analyze::BuildWarnings < Micro::Case
  flow Dates, Domain, TopLevelDomain, self.call!

  attributes :date_warnings, :domain_warnings, :top_level_domain_warnings

  def call!
    Success result: { warnings: date_warnings + domain_warnings + top_level_domain_warnings }
  end
end
