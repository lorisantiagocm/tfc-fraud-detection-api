class WhoisInformation::Analyze::Save < Micro::Case
  attributes :domain, :whois_information, :warnings, :ip

  def call!
    lookup = DomainLookup.create(
      ip: ip,
      domain: domain,
      whois_information: whois_information,
      warnings: warnings.map { |w| { type: w.type, data: w.data } }
    )

    if lookup.errors.any?
      return Failure result: { message: "Erro ao criar consulta: #{lookup.errors.full_messages}" }
    end

    Success result: { lookup: lookup }
  end
end
