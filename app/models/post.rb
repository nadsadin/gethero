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
class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged]
  has_one_attached :preview

  # Validators
  validates :title, presence: true
  validates :text, presence: true
end
