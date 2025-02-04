class CreateDomainLookup < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_lookups do |t|
      t.references :domain, null: false, foreign_key: true
      t.references :whois_information, null: false, foreign_key: true
      t.jsonb :warnings, default: []
      t.string :ip

      t.timestamps
    end
  end
end
