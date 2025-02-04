class WhoisInformation::Analyze::Dates < Micro::Case
  attributes :created_at, :last_updated_at

  def call!
    suspect_created_at = created_at.present? && created_at < 1.year.ago
    suspect_updated_at = last_updated_at.present? && last_updated_at < 1.year.ago

    Success result: { suspect_created_at: suspect_created_at, suspect_updated_at: suspect_updated_at }
  end
end
