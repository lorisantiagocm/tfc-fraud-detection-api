class CreateDomains < ActiveRecord::Migration[8.0]
  def change
    create_table :domains do |t|
      t.string :name, null: false
      t.boolean :trusted, default: false, null: false
      t.integer :searched_amount, default: 0, null: false

      t.timestamps
    end
  end
end
