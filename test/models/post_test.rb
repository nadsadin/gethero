# == Schema Information
#
# Table name: posts
#
#  id              :bigint           not null, primary key
#  description     :string
#  seo_description :string
#  seo_title       :string
#  slug            :string
#  text            :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_posts_on_slug  (slug) UNIQUE
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
