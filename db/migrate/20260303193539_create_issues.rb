class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.references :property, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :incident_date

      t.timestamps
    end
  end
end
