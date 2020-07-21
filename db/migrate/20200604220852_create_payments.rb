class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.bigint :target_id
      t.string :target_type
      t.integer :status
      t.string :transaction_id
      t.integer :amount

      t.timestamps
    end
    add_index :payments, :transaction_id, unique: true
  end
end
