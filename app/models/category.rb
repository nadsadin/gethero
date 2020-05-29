# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string
#  plural     :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry  (ancestry)
#  index_categories_on_slug      (slug) UNIQUE
#
class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  has_and_belongs_to_many :personal_pages
  has_ancestry
  strip_attributes only: [:slug]
end
