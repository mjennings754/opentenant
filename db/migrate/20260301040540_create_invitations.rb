class CreateInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.datetime :accepted_at
      t.references :invitable, polymorphic: true
      t.references :inviter, polymorphic: true
      t.string :role
      t.references :invited_user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
