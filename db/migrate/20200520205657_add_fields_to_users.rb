class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :midname, :string
    add_column :users, :phone, :string
    add_column :users, :inn, :string
    add_column :users, :about, :text
    add_column :users, :payment_token, :string
    add_column :users, :role, :integer
    add_column :users, :balance, :float
  end
end
