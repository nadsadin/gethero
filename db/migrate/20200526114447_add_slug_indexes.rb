class AddSlugIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, :slug, unique: true
    add_index :posts, :slug, unique: true
    add_index :categories, :slug, unique: true
    add_index :personal_pages, :nickname, unique: true
  end
end
