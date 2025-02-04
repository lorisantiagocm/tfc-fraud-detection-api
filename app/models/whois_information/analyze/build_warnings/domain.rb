class WhoisInformation::Analyze::BuildWarnings::Domain < Micro::Case
  attributes :domain_found_suspect_terms, :known_trusted_domain

  def call!
    warnings = []
    if domain_found_suspect_terms && known_trusted_domain.empty?
      warnings << WhoisInformation::Warning.new(type: :suspect_domain_term, data: domain_found_suspect_terms.join(", "))
    end

    Success result: { domain_warnings: warnings }
  end
end
