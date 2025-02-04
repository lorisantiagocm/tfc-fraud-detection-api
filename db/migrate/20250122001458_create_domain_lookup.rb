class CreateDomainLookup < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_lookups do |t|
      t.references :domain, null: false, foreign_key: true
      t.references :whois_information, null: false, foreign_key: true
      t.string :warnings, default: [], array: true
      t.string :ip
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
