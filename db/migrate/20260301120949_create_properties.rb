class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :address_line_one
      t.string :address_line_two
      t.string :postcode
      t.string :city
      t.string :state
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
