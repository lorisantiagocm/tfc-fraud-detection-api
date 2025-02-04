class WhoisInformation::Analyze::ThirdLevelDomain < Micro::Case
  attributes :third_level_domain

  SUSPECT_TERMS = %w[bradesco itau bancodobrasil outback flamengo caixa]

  def call!
    if third_level_domain.nil?
      return Success result: { third_level_domain_suspected_terms: [] }
    end

    found_suspect_terms = []

    SUSPECT_TERMS.each do |term|
      found_suspect_terms << third_level_domain.include?(term)
    end

    Success result: { third_level_domain_suspected_terms: found_suspect_terms }
  end
end
