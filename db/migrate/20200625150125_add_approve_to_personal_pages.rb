class AddApproveToPersonalPages < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_pages, :approved_at, :datetime
  end
end
