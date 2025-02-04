class WhoisInformation::Analyze < Micro::Case
  flow  BreakDownDomain,
        ::WhoisInformation::Fetch,
        Dates,
        Domain,
        Protocol,
        TopLevelDomain,
        ThirdLevelDomain,
        BuildWarnings,
        Save
end
