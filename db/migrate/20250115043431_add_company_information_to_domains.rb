class AddCompanyInformationToDomains < ActiveRecord::Migration[8.0]
  def change
    add_column :domains, :owner_name, :string
    add_column :domains, :owner_cnpj, :string
    add_column :domains, :trusted_at, :datetime
  end
end
