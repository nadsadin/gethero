class CreateDonates < ActiveRecord::Migration[5.2]
  def change
    create_table :donates do |t|
      t.references :personal_page, foreign_key: true
      t.integer :amount
      t.integer :status
      t.string :comment

      t.timestamps
    end
  end
end
