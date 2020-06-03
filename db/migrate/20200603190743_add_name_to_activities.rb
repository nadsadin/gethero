class AddNameToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :name, :string
    add_column :activities, :slug, :string
  end
end
