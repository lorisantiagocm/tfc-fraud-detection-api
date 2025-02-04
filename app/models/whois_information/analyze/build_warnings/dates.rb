class WhoisInformation::Analyze::BuildWarnings::Dates < Micro::Case
  attributes :created_at, :suspect_created_at, :suspect_updated_at, :last_updated_at

  def call!
    warnings = []
    if suspect_created_at
      warnings << WhoisInformation::Warning.new(type: :recently_created_domain, data: created_at)
    end

    if suspect_updated_at
      warnings << WhoisInformation::Warning.new(type: :recently_updated_domain, data: last_updated_at)
    end

    Success result: { date_warnings: warnings }
  end
end
