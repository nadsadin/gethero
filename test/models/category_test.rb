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
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
