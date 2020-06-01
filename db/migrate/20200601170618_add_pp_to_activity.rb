class AddPpToActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :personal_page, foreign_key: true
  end
end
