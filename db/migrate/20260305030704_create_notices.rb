class CreateNotices < ActiveRecord::Migration[8.1]
  def change
    create_table :notices do |t|
      t.references :property, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
