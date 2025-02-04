class CreateDomainLookups < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_lookups do |t|
      t.references :user, foreign_key: true
      t.references :domain, foreign_key: true
      t.references :whois_information, foreign_key: true
      t.jsonb :warnings, default: [], array: true
      t.string :ip

      t.timestamps
    end
  end
end
