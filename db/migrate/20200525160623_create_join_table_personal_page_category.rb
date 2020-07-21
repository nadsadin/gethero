class CreateJoinTablePersonalPageCategory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :personal_pages, :categories do |t|
      t.index [:personal_page_id, :category_id], name: 'index_ppage_category'
      t.index [:category_id, :personal_page_id], name: 'index_category_ppage'
    end
  end
end
