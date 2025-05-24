class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.references :proponent, null: false, foreign_key: true
      t.integer :contact_type, default: 1
      t.string :value, null: false

      t.timestamps
    end
  end
end
