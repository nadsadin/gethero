class AddFieldsToPersonalPages < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_pages, :name, :string
    add_column :personal_pages, :short_description, :string
  end
end
