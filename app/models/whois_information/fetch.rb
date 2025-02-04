class WhoisInformation::Fetch < Micro::Case
  attributes :domain_name, :whois_formatted_domain

  def call!
    domain = Domain.create_or_find_by(name: domain_name)
    return Failure result: { message: "Domain could not be created" } if domain.nil?

    whois_information = WhoisInformation.where(domain: domain.id).where("created_at < ?", Time.current - 2.days).first

    if whois_information.nil?
      response = HTTParty.get("https://api.whoxy.com/?key=e0af321ba6d4965eoaea9d9d9ac2344b9&whois=#{whois_formatted_domain}")

      if response.body.nil? || !response.ok? || response.parsed_response["status"] == 0
        return Success result: { whois_information: nil, domain: domain }
      end

      whois_information = WhoisInformation.create(
        owner_name: response.parsed_response.dig("registrant_contact", "full_name"),
        owner_email: response.parsed_response.dig("registrant_contact", "email_address"),
        registered_at: response.parsed_response["create_date"],
        iana_id: response.parsed_response.dig("domain_registrar", "iana_id"),
        owner_phone_number: response.parsed_response.dig("registrant_contact", "phone_number"),
        last_updated_at: response.parsed_response["update_date"],
        expires_at: response.parsed_response["expiry_date"],
        name_servers: response.parsed_response["name_servers"],
        whois_server: response.parsed_response["whois_server"],
        domain_statuses: response.parsed_response["domain_status"],
        domain_id: domain.id
      )
    end

    if whois_information.nil?
      return Failure result: { message: "Whois data could not be created: #{whois_information.errors.full_messages}" }
    end

    Success result: { whois_information: whois_information, domain: domain }
  end
end

# {
#   "status": 1,
#   "domain_name": "excite.com",
#   "query_time": "2016-06-11 19:19:24",
#   "whois_server": "whois.markmonitor.com",
#   "domain_registered": "yes",
#   "create_date": "1995-09-19",
#   "update_date": "2016-04-26",
#   "expiry_date": "2017-09-18",
#   "domain_registrar": {
#     "iana_id": 292,
#     "registrar_name": "MarkMonitor, Inc.",
#     "whois_server": "whois.markmonitor.com",
#     "website_url": "http://www.markmonitor.com",
#     "email_address": "abusecomplaints@markmonitor.com",
#     "phone_number": "+1.2083895740"
#   },
#   "registrant_contact": {
#     "full_name": "Domain Administrator",
#     "company_name": "Mindspark Interactive Network, Inc.",
#     "mailing_address": "29 Wells Ave,",
#     "city_name": "Yonkers",
#     "state_name": "NY",
#     "zip_code": "10701",
#     "country_name": "United States",
#     "country_code": "US",
#     "email_address": "dnsmanager@mindspark.com",
#     "phone_number": "+1.9145912000",
#     "fax_number": "+1.9142064559"
#   },
#   "administrative_contact": {
#     "full_name": "Domain Administrator",
#     "company_name": "Mindspark Interactive Network, Inc.",
#     "mailing_address": "29 Wells Ave,",
#     "city_name": "Yonkers",
#     "state_name": "NY",
#     "zip_code": "10701",
#     "country_name": "United States",
#     "country_code": "US",
#     "email_address": "dnsmanager@mindspark.com",
#     "phone_number": "+1.9145912000",
#     "fax_number": "+1.9142064559"
#   },
#   "technical_contact": {
#     "full_name": "Domain Administrator",
#     "company_name": "Mindspark Interactive Network, Inc.",
#     "mailing_address": "29 Wells Ave,",
#     "city_name": "Yonkers",
#     "state_name": "NY",
#     "zip_code": "10701",
#     "country_name": "United States",
#     "country_code": "US",
#     "email_address": "dnsmanager@mindspark.com",
#     "phone_number": "+1.9145912000",
#     "fax_number": "+1.9142064559"
#   },
#   "name_servers": [
#     "ns5.iaccap.com",
#     "ns6.iaccap.com",
#     "ns1.iaccap.com"
#   ],
#   "domain_status": [
#     "clientUpdateProhibited",
#     "clientTransferProhibited",
#     "clientDeleteProhibited"
#   ],
#   "raw_whois": "Domain Name: excite.com\nRegistry Domain ID: 287299_DOMAIN_COM-VRSN\nRegistrar WHOIS Server: whois.markmonitor.com\nRegistrar URL: http://www.markmonitor.com\nUpdated Date: 2016-04-26T09:28:54-0700\nCreation Date: 1995-09-18T21:00:00-0700\nRegistrar Registration Expiration Date: 2017-09-17T21:00:00-0700\nRegistrar: MarkMonitor, Inc.\nRegistrar IANA ID: 292\nRegistrar Abuse Contact Email: abusecomplaints@markmonitor.com\nRegistrar Abuse Contact Phone: +1.2083895740\nDomain Status: clientUpdateProhibited (https://www.icann.org/epp#clientUpdateProhibited)\nDomain Status: clientTransferProhibited (https://www.icann.org/epp#clientTransferProhibited)\nDomain Status: clientDeleteProhibited (https://www.icann.org/epp#clientDeleteProhibited)\nRegistry Registrant ID: \nRegistrant Name: Domain Administrator\nRegistrant Organization: Mindspark Interactive Network, Inc.\nRegistrant Street: 29 Wells Ave, \nRegistrant City: Yonkers\nRegistrant State/Province: NY\nRegistrant Postal Code: 10701\nRegistrant Country: US\nRegistrant Phone: +1.9145912000\nRegistrant Phone Ext: \nRegistrant Fax: +1.9142064559\nRegistrant Fax Ext: \nRegistrant Email: dnsmanager@mindspark.com\nRegistry Admin ID: \nAdmin Name: Domain Administrator\nAdmin Organization: Mindspark Interactive Network, Inc.\nAdmin Street: 29 Wells Ave, \nAdmin City: Yonkers\nAdmin State/Province: NY\nAdmin Postal Code: 10701\nAdmin Country: US\nAdmin Phone: +1.9145912000\nAdmin Phone Ext: \nAdmin Fax: +1.9142064559\nAdmin Fax Ext: \nAdmin Email: dnsmanager@mindspark.com\nRegistry Tech ID: \nTech Name: Domain Administrator\nTech Organization: Mindspark Interactive Network, Inc.\nTech Street: 29 Wells Ave, \nTech City: Yonkers\nTech State/Province: NY\nTech Postal Code: 10701\nTech Country: US\nTech Phone: +1.9145912000\nTech Phone Ext: \nTech Fax: +1.9142064559\nTech Fax Ext: \nTech Email: dnsmanager@mindspark.com\nName Server: ns5.iaccap.com\nName Server: ns6.iaccap.com\nName Server: ns1.iaccap.com\nDNSSEC: unsigned\nURL of the ICANN WHOIS Data Problem Reporting System: http://wdprs.internic.net/\n>>> Last update of WHOIS database: 2016-06-11T12:19:24-0700 <<<\n\nThe Data in MarkMonitor.com's WHOIS database is provided by MarkMonitor.com for\ninformation purposes, and to assist persons in obtaining information about or\nrelated to a domain name registration record.  MarkMonitor.com does not guarantee\nits accuracy.  By submitting a WHOIS query, you agree that you will use this Data\nonly for lawful purposes and that, under no circumstances will you use this Data to:\n (1) allow, enable, or otherwise support the transmission of mass unsolicited,\n     commercial advertising or solicitations via e-mail (spam); or\n (2) enable high volume, automated, electronic processes that apply to\n     MarkMonitor.com (or its systems).\nMarkMonitor.com reserves the right to modify these terms at any time.\nBy submitting this query, you agree to abide by this policy.\n\nMarkMonitor is the Global Leader in Online Brand Protection.\n\nMarkMonitor Domain Management(TM)\nMarkMonitor Brand Protection(TM)\nMarkMonitor AntiPiracy(TM)\nMarkMonitor AntiFraud(TM)\nProfessional and Managed Services\n\nVisit MarkMonitor at http://www.markmonitor.com\nContact us at +1.8007459229\nIn Europe, at +44.02032062220\n\nFor more information on Whois status codes, please visit\n https://www.icann.org/resources/pages/epp-status-codes-2014-06-16-en"
# }
