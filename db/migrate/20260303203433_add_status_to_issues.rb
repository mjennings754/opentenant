class AddStatusToIssues < ActiveRecord::Migration[8.1]
  def change
    add_column :issues, :status, :string
  end
end
