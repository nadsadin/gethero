class CreateWithdrawals < ActiveRecord::Migration[5.2]
  def change
    create_table :withdrawals do |t|
      t.float :amount
      t.string :client_transaction
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
