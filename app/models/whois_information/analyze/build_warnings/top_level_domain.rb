class WhoisInformation::Analyze::BuildWarnings::TopLevelDomain < Micro::Case
  attributes :top_level_domain, :top_domain_trusted_terms, :top_domain_country_terms

  def call!
    warnings = []
    if top_domain_trusted_terms.empty? && top_domain_country_terms.empty?
      warnings << WhoisInformation::Warning.new(type: :uncommon_top_level_domain, data: top_level_domain)
    elsif top_domain_country_terms.any?
      warnings << WhoisInformation::Warning.new(type: :check_country_code, data: top_level_domain)
    end

    Success result: { top_level_domain_warnings: warnings }
  end
end
