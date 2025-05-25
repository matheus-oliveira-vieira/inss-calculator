class CreateProponents < ActiveRecord::Migration[8.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :email
      t.string :cpf, null: false
      t.date :birth_date
      t.decimal :salary, precision: 10, scale: 2
      t.decimal :inss_discount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
