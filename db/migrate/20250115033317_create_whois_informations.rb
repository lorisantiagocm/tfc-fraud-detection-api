class CreateWhoisInformations < ActiveRecord::Migration[8.0]
  def change
    create_table :whois_informations do |t|
      t.string :owner_name
      t.string :owner_email
      t.date :registered_at
      t.string :iana_id
      t.string :owner_phone_number
      t.date :last_updated_at
      t.date :expires_at
      t.string :name_servers, default: [], array: true
      t.string :whois_server
      t.string :domain_statuses, default: [], array: true
      t.references :domain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
