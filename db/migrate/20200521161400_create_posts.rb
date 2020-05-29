class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.text :text
      t.string :slug
      t.string :seo_title
      t.string :seo_description

      t.timestamps
    end
  end
end
