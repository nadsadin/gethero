class CreateCcConfirmations < ActiveRecord::Migration[5.2]
  def change
    create_table :cc_confirmations do |t|
      t.string :transaction_id
      t.string :mnt_transaction_id
      t.string :amount
      t.integer :status
      t.references :user, foreign_key: true

      t.index :transaction_id, unique: true
      t.timestamps
    end
  end
end
