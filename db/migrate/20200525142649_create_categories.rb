class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.string :plural
      t.string :ancestry

      t.timestamps
    end
    add_index :categories, :ancestry
  end
end
