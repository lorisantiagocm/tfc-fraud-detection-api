class WhoisInformation::Analyze::WhoisStatus < Micro::Case
  attributes :whois_statuses

  SUSPECT_STATUSES = %w[clientTransferProhibited]
  def call!
    suspect_statuses = SUSPECT_STATUSES && whois_statuses

    Success result: { suspect_statuses: suspect_statuses }
  end
end
