class CreatePersonalPages < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_pages do |t|
      t.references :user, foreign_key: true
      t.string :nickname
      t.text :about

      t.timestamps
    end
  end
end
