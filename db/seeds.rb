# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.create(
#   email: 'teste@teste.com',
#   password: 'qwe123!'
# )

trusted_domains = %w[https://www.correios.com.br https://www.google.com https://shopee.com.br https://www.temu.com]

trusted_domains.each do |domain|
  result = WhoisInformation::Analyze::BreakDownDomain.call(searched_url: domain)

  Domain.create(
    name: result[:domain_name],
    trusted: true
  )
end
